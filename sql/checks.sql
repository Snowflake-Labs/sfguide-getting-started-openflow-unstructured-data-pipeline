-- Copyright 2025 Snowflake Inc.
-- SPDX-License-Identifier: Apache-2.0
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
-- http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.

-- use created role
use role FESTIVAL_DEMO_ROLE;
use warehouse FESTIVAL_DEMO_S;
use database OPENFLOW_FESTIVAL_DEMO;
create schema if not exists FESTIVAL_OPS;
use schema FESTIVAL_OPS;

show tables;
show stages;


desc table docs_chunks;
desc table docs_groups;
desc table docs_perms;
desc table doc_group_perms;
desc table file_hashes;
desc table perms_groups;


select * from docs_chunks;

select DISTINCT METADATA:id::string as id, METADATA:fullName::string as filename from docs_chunks;

select count(DOC_ID) from file_hashes where lower(DOC_ID) like '%strategy%';

select * from file_hashes;
-- truncate file_hashes;
-- Check document count by category
-- Comprehensive document verification by demo category
SELECT 
    COUNT(*) as total_docs,

    -- Strategic Planning Documents (Expected: 7-8)
    COUNT(CASE WHEN 
        lower(DOC_ID) LIKE '%strategy%' OR 
        lower(DOC_ID) LIKE '%board%meeting%' OR 
        lower(DOC_ID) LIKE '%meeting%minutes%' OR
        lower(DOC_ID) LIKE '%financial%analysis%' OR
        lower(DOC_ID) LIKE '%q3%2024%financial%'
    THEN 1 END) as strategic_docs,

    -- Operations Excellence Documents (Expected: 6-7)
    COUNT(CASE WHEN 
        (lower(DOC_ID) LIKE '%operation%manual%' OR lower(DOC_ID) LIKE '%venue%setup%') OR
        (lower(DOC_ID) LIKE '%sound%system%' AND lower(DOC_ID) LIKE '%project%') OR
        (lower(DOC_ID) LIKE '%post%event%analysis%')
    THEN 1 END) as operations_docs,

    -- Compliance & Risk Documents (Expected: 3-4)
    COUNT(CASE WHEN 
        (lower(DOC_ID) LIKE '%health%safety%' OR lower(DOC_ID) LIKE '%safety%policy%') OR
        (lower(DOC_ID) LIKE '%service%agreement%' OR lower(DOC_ID) LIKE '%audio%equipment%') OR
        (lower(DOC_ID) LIKE '%post%event%analysis%')
    THEN 1 END) as compliance_docs,

    -- Knowledge Management Documents (Expected: 1)
    COUNT(CASE WHEN 
        lower(DOC_ID) LIKE '%training%guide%' OR 
        lower(DOC_ID) LIKE '%customer%service%training%'
    THEN 1 END) as training_docs,

    -- Document format breakdown
    COUNT(CASE WHEN lower(DOC_ID) LIKE '%.jpg' THEN 1 END) as jpg_files,
    COUNT(CASE WHEN lower(DOC_ID) LIKE '%.pdf' THEN 1 END) as pdf_files,
    COUNT(CASE WHEN lower(DOC_ID) LIKE '%.docx' THEN 1 END) as docx_files,
    COUNT(CASE WHEN lower(DOC_ID) LIKE '%.pptx' THEN 1 END) as pptx_files

FROM file_hashes;


select * from docs_groups;

select * from docs_perms;
-- truncate docs_perms;

select * from doc_group_perms;

select * from perms_groups;

ls @documents;