# coding=utf-8

import boto, boto.sts

def main():
    sts_connection = boto.sts.STSConnection()
    assumed_role_object = sts_connection.assume_role(
        role_arn='arn:aws:iam::11111111111:role/xxxxxxxxxxxxxxx',
        role_session_name="NNNNN"
    )

    conn = boto.connect_s3(
        aws_access_key_id=assumed_role_object.credentials.access_key,
        aws_secret_access_key=assumed_role_object.credentials.secret_key,
        security_token=assumed_role_object.credentials.session_token
    )
    bucket = conn.get_bucket('TARGET_BUCKET')
    key = bucket.get_key('xxxxxx/20151128/test.txt')

    print(key.get_contents_as_string())


if __name__ == "__main__":
    main()
