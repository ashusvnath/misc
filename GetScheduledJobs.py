#!/usr/bin/env python3
#AWS-LAMBDA-ENV-AMI : amzn-ami-hvm-2017.03.1.20170812-x86_64-gp2
from base64 import b64encode
from copy import copy
import os
import functools
import json
import re
import time
from urllib.parse import quote_plus
from urllib.request import Request, urlopen
import xml.etree.ElementTree as ET

from boto3 import resource as aws_resource
from boto3.dynamodb.types import Decimal
dynamodb=aws_resource('dynamodb')

ENV = os.environ
GO_HOST = ENV["GO_HOST"]
GO_USER = ENV["GO_USER"]
GO_PASS = ENV["GO_PASS"]
PATTERN = ENV["BUILD_LOCATOR_PATTERN"]
TIMEOUT = int(ENV["SCHEDULING_TIMEOUT_IN_SECONDS"])
SLACK_HOOK_URL = ENV["SLACK_HOOK_URL"]

def fetchScheduledJobsXML():
  auth_string = "%s:%s" % (GO_USER, GO_PASS)
  basic_auth_header_value = "Basic " + b64encode(bytes(auth_string, "utf-8")).decode("utf-8")
  go_scheduled_jobs_url = "https://%s/go/api/jobs/scheduled.xml" % (GO_HOST)
  r = Request(url=go_scheduled_jobs_url)
  r.add_header("Authorization", basic_auth_header_value)
  result = ""
  with urlopen(r) as f:
    result = f.read()
  return result

def parseAndFilterInterestingBuildLocators(xml):
  doc = ET.fromstring(xml)
  buildLocators = doc.findall(".//buildLocator")
  return functools.reduce(lambda a,x: a + [x.text], buildLocators, [])

def selectByPattern(locators):
  t = time.time()
  p = re.compile(PATTERN)
  result = {}
  filtered_locators = filter(lambda x: p.search(x), locators)
  for locator in filtered_locators:
    result[locator]= t
  return result

def mergeCleanSchedules(existingScheduledJobs, currentScheduledJobs):
  assignedJobLocators = []
  locators = list(existingScheduledJobs.keys())
  merged = copy(currentScheduledJobs)
  for locator in locators:
    if(currentScheduledJobs.get(locator)):
      #existing job, keep timestamp
      merged[locator] = existingScheduledJobs[locator]
      if currentScheduledJobs[locator] - existingScheduledJobs[locator] > TIMEOUT:
        postToSlack(locator)
    else:
      #job has been assigned, forget about it
      assignedJobLocators.append(locator)
  return (merged, assignedJobLocators)

def getFromDB():
  scheduledJobs = dynamodb.Table('ScheduledJobs')
  existingSchedules={}
  for item in scheduledJobs.scan()['Items']:
    existingSchedules[item['JobLocator']] = float(item['start_time_epoch'])
  return existingSchedules

def updateDB(updatedData, locatorsToRemove):
  scheduledJobs = dynamodb.Table('ScheduledJobs')
  with scheduledJobs.batch_writer() as batch:
    for locator in updatedData:
      batch.put_item(Item={
        "JobLocator": locator,
        "start_time_epoch": Decimal(str(updatedData[locator]))})
    for locator in locatorsToRemove:
      print("Removing %s" % (locator))
      batch.delete_item(Key={'JobLocator': locator})

def postToSlack(job_locator):
  job_detail_link = "https://%s/go/tab/build/detail/%s" % (GO_HOST, job_locator)
  text = "@mingle-devs The job <%s|%s> is scheduled but not assigned to an agent for more than %d seconds. Please take a look!."
  data = {
    "text": text % (job_detail_link, job_locator, TIMEOUT),
    "link_names": 1,
  }
  req = Request(url=SLACK_HOOK_URL, method='POST',
                data=bytes(json.dumps(data), 'utf-8'))
  urlopen(req)

def process(foo, bar):
  xml = fetchScheduledJobsXML()
  locators = parseAndFilterInterestingBuildLocators(xml)
  currentScheduledJobs = selectByPattern(locators)
  existingScheduledJobs = getFromDB()
  updatedData, locatorsToPruge = mergeCleanSchedules(existingScheduledJobs, currentScheduledJobs)
  updateDB(updatedData, locatorsToPruge)

if __name__ == '__main__':
  process('foo', 'bar')