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

-- =====================================================
-- Festival Operations Cortex Search Service Information
-- NOTE: Cortex Search service is created AUTOMATICALLY by Openflow
-- Google Drive (Cortex connect) connector - no manual creation needed!
-- =====================================================

-- Set context
USE ROLE FESTIVAL_DEMO_ROLE;
USE DATABASE OPENFLOW_FESTIVAL_DEMO;
USE SCHEMA FESTIVAL_OPS;

-- =====================================================
-- VERIFICATION QUERIES
-- Check auto-created Cortex Search services
-- =====================================================

-- List all Cortex Search services (including auto-created ones)
SHOW CORTEX SEARCH SERVICES;

-- Get details of the Festival Operations search service
DESCRIBE CORTEX SEARCH SERVICE FESTIVAL_OPS_SEARCH_SERVICE;

-- =====================================================
-- SAMPLE VALIDATION QUERIES
-- Test the auto-created service after Openflow processing
-- =====================================================

-- Example query structure to test the search service
SELECT PARSE_JSON(
  SNOWFLAKE.CORTEX.SEARCH_PREVIEW(
      'FESTIVAL_OPS_SEARCH_SERVICE',
      '{
        "query": "festival operations customer service",
        "columns": [
            "chunk",
            "full_name", 
            "web_url",
            "last_modified_date_time"
        ],
        "limit": 3
      }'
  )
)['results'] as search_test_results;

-- =====================================================
-- BUSINESS INTELLIGENCE SAMPLE QUERIES
-- Ready-to-use queries for demo purposes
-- =====================================================

-- Strategic Planning Intelligence
SELECT PARSE_JSON(
  SNOWFLAKE.CORTEX.SEARCH_PREVIEW(
      'FESTIVAL_OPS_SEARCH_SERVICE',
      '{
        "query": "2025 expansion plans target markets revenue growth",
        "columns": ["chunk", "full_name", "web_url", "last_modified_date_time"],
        "limit": 5
      }'
  )
)['results'] as strategic_insights;

-- Operations Excellence Intelligence  
SELECT PARSE_JSON(
  SNOWFLAKE.CORTEX.SEARCH_PREVIEW(
      'FESTIVAL_OPS_SEARCH_SERVICE',
      '{
        "query": "technology modernization projects budgets sound system upgrade",
        "columns": ["chunk", "full_name", "web_url", "last_modified_date_time"],
        "limit": 5
      }'
  )
)['results'] as operations_insights;

-- Compliance & Risk Intelligence
SELECT PARSE_JSON(
  SNOWFLAKE.CORTEX.SEARCH_PREVIEW(
      'FESTIVAL_OPS_SEARCH_SERVICE',
      '{
        "query": "health safety policies medical procedures regulatory compliance",
        "columns": ["chunk", "full_name", "web_url", "last_modified_date_time"],
        "limit": 5
      }'
  )
)['results'] as compliance_insights;

-- Knowledge Management Intelligence
SELECT PARSE_JSON(
  SNOWFLAKE.CORTEX.SEARCH_PREVIEW(
      'FESTIVAL_OPS_SEARCH_SERVICE',
      '{
        "query": "training materials staff development customer service excellence",
        "columns": ["chunk", "full_name", "web_url", "last_modified_date_time"],
        "limit": 5
      }'
  )
)['results'] as training_insights;

-- =====================================================
-- IMPORTANT NOTES
-- =====================================================

/*
🤖 AUTOMATIC CORTEX SEARCH CREATION:
   - Service is created automatically by Openflow Google Drive (Cortex connect) connector
   - No manual CREATE CORTEX SEARCH SERVICE commands needed
   - Service name: FESTIVAL_OPS_SEARCH_SERVICE
   - Arctic embeddings (snowflake-arctic-embed-m-v1.5) configured automatically
   - Document indexing happens automatically during Openflow processing

📊 AVAILABLE COLUMNS:
   - chunk: Document text content chunks
   - full_name: Document file name with extension
   - web_url: Google Drive web URL for the document
   - last_modified_date_time: Last modification timestamp
   - DOC_ID: Unique document identifier
   - user_emails: Array of user email addresses with access
   - user_ids: Array of user IDs with access

📊 DEMO WORKFLOW:
   1. Set up Openflow Google Drive (Cortex connect) connector
   2. Point connector to "Festival Operations" shared drive
   3. Start connector - it automatically:
      - Processes all documents (PDF, DOCX, PPTX, JPG)
      - Creates Cortex Search service (FESTIVAL_OPS_SEARCH_SERVICE)
      - Indexes content with metadata
   4. Use SHOW CORTEX SEARCH SERVICES to verify service creation
   5. Run natural language queries using the queries above

🔍 BUSINESS VALUE:
   - Executives can ask questions like "What are our 2025 expansion plans?"
   - Operations teams can query "Find technology modernization projects"
   - Compliance teams can search "Show health and safety policies"
   - All without writing SQL - natural language intelligence!
*/
