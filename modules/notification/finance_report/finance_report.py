import boto3
import argparse
import sys
import os

from datetime import datetime, timedelta

SOURCE_EMAIL = os.environ.get("SOURCE_EMAIL")
RECIPIENTS = os.environ.get("RECIPIENTS")
REPORT_GRANULARITY = os.environ.get("REPORT_GRANULARITY")


def send_email(client, message_subject, message_content):
    client.send_email(
        FromEmailAddress=SOURCE_EMAIL,
        Destination={"ToAddresses": [addr for addr in RECIPIENTS.split(";")]},
        Content={
            "Simple": {
                "Subject": {"Data": message_subject, "Charset": "UTF-8"},
                "Body": {"Text": {"Charset": "UTF-8", "Data": message_content}},
            },
        },
    )


def get_report(client, start, end):
    response = client.get_cost_and_usage(
        TimePeriod={
            "Start": start.strftime("%Y-%m-%d"),
            "End": end.strftime("%Y-%m-%d"),
        },
        Granularity="DAILY",
        Metrics=["BlendedCost"],
        Filter={"Dimensions": {"Key": "SERVICE", "Values": ["AmazonEC2"]}},
    )
    return response["ResultsByTime"]


def main():
    # Argument Preperation
    parser = argparse.ArgumentParser()
    parser.add_argument("--dry-run", action="store_true")
    args = parser.parse_args()

    cost_client = boto3.client("ce")
    email_client = boto3.client("sesv2")

    # Report Preperation
    end_date = datetime.now()
    start_date = end_date - timedelta(days=1)
    report = get_report(cost_client, start_date, end_date)[0]
    cost = (
        report["Total"]["BlendedCost"]["Amount"]
        + " "
        + report["Total"]["BlendedCost"]["Unit"]
    )
    if args.dry_run:
        print(cost)
        sys.exit(0)
    # Email Preperation
    email_subject = f"Finance Report For {end_date.strftime("%m-%d")}"
    email_body = f"Cost: {cost}"
    email_body = "------------------\n"
    send_email(email_client, email_subject, email_body)


main()
