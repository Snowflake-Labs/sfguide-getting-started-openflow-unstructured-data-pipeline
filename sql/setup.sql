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
-- Create role and warehouse
USE ROLE ACCOUNTADMIN;
CREATE ROLE IF NOT EXISTS FESTIVAL_DEMO_ROLE;
CREATE WAREHOUSE IF NOT EXISTS FESTIVAL_DEMO_S
  WAREHOUSE_SIZE = SMALL
  AUTO_SUSPEND = 300
  AUTO_RESUME = TRUE;
GRANT USAGE ON WAREHOUSE FESTIVAL_DEMO_S TO ROLE FESTIVAL_DEMO_ROLE;

-- Create database and grant ownership
CREATE DATABASE IF NOT EXISTS OPENFLOW_FESTIVAL_DEMO;
GRANT OWNERSHIP ON DATABASE OPENFLOW_FESTIVAL_DEMO TO ROLE FESTIVAL_DEMO_ROLE;

-- Grant role to current user
SET CURR_USER=(SELECT CURRENT_USER());
GRANT ROLE FESTIVAL_DEMO_ROLE TO ROLE IDENTIFIER($CURR_USER);

-- Switch to demo role and create schema
USE ROLE FESTIVAL_DEMO_ROLE;
USE DATABASE OPENFLOW_FESTIVAL_DEMO;
CREATE SCHEMA IF NOT EXISTS FESTIVAL_OPS;

