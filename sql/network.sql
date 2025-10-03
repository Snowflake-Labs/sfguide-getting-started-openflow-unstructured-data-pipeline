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

use role kamesh_demos;
use database kamesh_demos;
use schema networks;
show network rules;

CREATE OR REPLACE NETWORK RULE google_network_rule
  MODE = EGRESS
  TYPE= HOST_PORT
  VALUE_LIST = (
                 'admin.googleapis.com',
                 'oauth2.googleapis.com',
                 'www.googleapis.com',
                 'google.com'
                );

DESC NETWORK RULE google_network_rule;

CREATE OR REPLACE NETWORK RULE kameshs_dev_network_rule
  MODE = EGRESS
  TYPE= HOST_PORT
  VALUE_LIST = ('kameshs.dev');

DESC NETWORK RULE kameshs_dev_network_rule;

CREATE OR REPLACE EXTERNAL ACCESS INTEGRATION kamesh_openflow_demos_access_integration
  ALLOWED_NETWORK_RULES = (kamesh_demos.networks.google_network_rule,kamesh_demos.networks.kameshs_dev_network_rule)
  ENABLED = true;

ALTER EXTERNAL ACCESS INTEGRATION kamesh_openflow_demos_access_integration SET COMMENT = 'Used when creating runtimes with Openflow SPCS ';

DESC EXTERNAL ACCESS INTEGRATION kamesh_openflow_demos_access_integration;

-- access and grants

GRANT USAGE ON DATABASE KAMESH_DEMOS TO OPENFLOW_ADMIN;
GRANT USAGE ON SCHEMA KAMESH_DEMOS.NETWORKS TO OPENFLOW_ADMIN;
GRANT USAGE ON INTEGRATION kamesh_openflow_demos_access_integration TO OPENFLOW_ADMIN;

-- check grants
SHOW GRANTS TO ROLE openflow_admin;
  