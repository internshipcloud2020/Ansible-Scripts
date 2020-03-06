#!/usr/bin/env python3

paginator = client.get_paginator('list_resource_record_sets')

try:
    source_zone_records = paginator.paginate(HostedZoneId='HostedZoneId')
    for record_set in source_zone_records:
        for record in record_set['ResourceRecordSets']:
            if record['Type'] == 'CNAME':
                print(record['Name'])

except Exception as error:
    print('An error occurred getting source zone records:')
    print(str(error))
    raise