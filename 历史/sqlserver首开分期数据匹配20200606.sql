----------------------------SYS_PROJECT_STAGE
--select 'update SYS_PROJECT_STAGE set is_first_open_period=0;'
--union all
--select 'update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='''+est2+''' and project_id='''+test1+''';' from [dbo].[Table_2]
--where est2 not in('一期/A地块二标段','一期/B地块')
--union all
--select 'update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name in(''无分期'' ,''1期'',''一期''); '
------------------------------MDM_PERIOD
--select 'update MDM_PERIOD set is_first_open_period=0; '
--union all
--select 'update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='''+est2+''' and PROJECT_ORIGINAL_ID='''+test1+''';' from [dbo].[Table_2]
--where est2 not in('一期/A地块二标段','一期/B地块')
--union all
--select 'update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME in(''无分期'' ,''1期'',''一期''); '

----update SYS_PROJECT_STAGE set is_first_open_period=0 where stage_name='' and project_id=''
----update MDM_PERIOD set is_first_open_period=0 where PERIOD_NAME='' and PROJECT_ORIGINAL_ID=''
update MDM_PERIOD set is_first_open_period=0; 
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='一期' and PROJECT_ORIGINAL_ID='37233b43-b08e-4a04-a4b0-93b9bc5f3b6e';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='一期' and PROJECT_ORIGINAL_ID='154758dd-a1a5-4f53-8dca-c221aae86bed';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='一期' and PROJECT_ORIGINAL_ID='f4e59426-0762-4af5-ab0b-ee1a7c2d894a';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='无分期' and PROJECT_ORIGINAL_ID='17879486-4345-48d1-81b9-4abd52654545';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='一期' and PROJECT_ORIGINAL_ID='a3a150c7-0afc-72d1-e053-8606160afd0d';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='无分期' and PROJECT_ORIGINAL_ID='3e7507a3-b76a-48c5-bd81-2820958ed919';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='无分期' and PROJECT_ORIGINAL_ID='ced8e2a9-e815-4a11-a590-33bcf009ab38';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='无分期' and PROJECT_ORIGINAL_ID='1daee593-2fa9-4e43-9aa6-ee820f488f0d';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='无分期' and PROJECT_ORIGINAL_ID='0700e078-4fa1-41bb-baf2-e0e670176271';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='一期' and PROJECT_ORIGINAL_ID='894e8218-f56a-4c35-91e1-c6e40b046eb4';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='无分期' and PROJECT_ORIGINAL_ID='74678201-8f21-4c5b-98b8-265bd0d45d24';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='无分期' and PROJECT_ORIGINAL_ID='e403db0f-888d-4095-ae42-fee099bb1201';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='无分期' and PROJECT_ORIGINAL_ID='275faae3-d811-47f8-8d69-0a3a42901be4';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='无分期' and PROJECT_ORIGINAL_ID='32dfa580-5a47-4b27-b6e9-fc9bf656872f';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='一期' and PROJECT_ORIGINAL_ID='179e3f6c-26c0-46e3-8791-b535b3bb8be0';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='无分期' and PROJECT_ORIGINAL_ID='a0d1ec37-fa4c-346a-e053-8606160a788a';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='无分期' and PROJECT_ORIGINAL_ID='3b300bde-d6d0-4a0f-8a34-e0816e358430';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='无分期' and PROJECT_ORIGINAL_ID='0f0f367a-cb20-4353-a545-73fa0b9aa67f';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='一期' and PROJECT_ORIGINAL_ID='60bcaed2-668c-4e9c-ad6b-1d1116d6fb8b';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='一期' and PROJECT_ORIGINAL_ID='3128727f-a9bb-4bbf-b034-630f5322f07f';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='无分期' and PROJECT_ORIGINAL_ID='446d08f3-034e-4777-919f-f800124b1021';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='一期' and PROJECT_ORIGINAL_ID='3fc32272-4195-48b2-894d-4d2bc80f2c6e';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='一期' and PROJECT_ORIGINAL_ID='753b6304-def7-49fb-8aa6-69411f35db4b';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='无分期' and PROJECT_ORIGINAL_ID='a474dd51-3783-4c07-8149-1c2b62dab8e8';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='无分期' and PROJECT_ORIGINAL_ID='282e5718-7934-4a22-b3ca-f592d258fc63';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='一期' and PROJECT_ORIGINAL_ID='e1b3e6ab-b881-4906-bb60-6905f3c005dd';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='住宅一期' and PROJECT_ORIGINAL_ID='29a8f34c-7736-4339-bc8f-9865c63e6119';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='无分期' and PROJECT_ORIGINAL_ID='9c97f412-b3f5-405b-892f-3ce6b658abce';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='无分期' and PROJECT_ORIGINAL_ID='ad71a781-ad71-4959-9192-1ff6851e9d61';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='一期' and PROJECT_ORIGINAL_ID='5cd38485-f4fa-4340-b156-5a6f4a090c0d';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='一期' and PROJECT_ORIGINAL_ID='a4d674f1-ad4d-424a-93bd-de63db9ef715';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='一期（赵沽里地块）' and PROJECT_ORIGINAL_ID='6e273234-29e6-4d03-8e16-2895b59b38cd';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='无分期' and PROJECT_ORIGINAL_ID='7e06d906-77fe-4185-9606-f5fb36752d28';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='二期' and PROJECT_ORIGINAL_ID='e7d9244d-3305-4ab7-a6ee-09ec206db5f7';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='无分期' and PROJECT_ORIGINAL_ID='5915a7dd-59f3-45d5-ab6b-0249a943aaa0';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='无分期' and PROJECT_ORIGINAL_ID='0cf75f5e-8aa6-4dad-be0f-d9f9a6993080';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='无分期' and PROJECT_ORIGINAL_ID='9d73bb2f-9f25-4bd7-bfc2-629022e83604';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='无分期' and PROJECT_ORIGINAL_ID='c287621c-b8bb-4ffd-af51-7ed60f3a2e54';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='无分期' and PROJECT_ORIGINAL_ID='6f41511f-f86e-4f24-8d0c-48afd448340d';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='无分期' and PROJECT_ORIGINAL_ID='947b093d-6cb3-4b80-a4bf-8f464cada323';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='一期' and PROJECT_ORIGINAL_ID='33ee5c3d-1517-480d-a502-5d9c1d70d19c';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='无分期' and PROJECT_ORIGINAL_ID='719482ac-9e56-4b7d-bfe0-2e01e0c806e4';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='无分期' and PROJECT_ORIGINAL_ID='e7e8a64b-ffb3-4fb9-a876-28dbdd850aae';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='无分期' and PROJECT_ORIGINAL_ID='aca43c52-082b-47df-a494-84b7ea6b9f55';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='无分期' and PROJECT_ORIGINAL_ID='97e5ebfa-4c8b-47f2-99b6-b58f06a51b36';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='无分期' and PROJECT_ORIGINAL_ID='1c8bc758-3d13-4c9a-834c-1123d6c4874f';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='无分期' and PROJECT_ORIGINAL_ID='23730850-ea5d-44de-b980-a3bb65ab0098';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='无分期' and PROJECT_ORIGINAL_ID='8ebb8dfd-ece6-448d-8caf-c9bb49c92d65';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='1期' and PROJECT_ORIGINAL_ID='8b1cf7eb-ba01-44f5-8c2d-1f40d0ce8b04';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='1期' and PROJECT_ORIGINAL_ID='b4a0b606-0e09-4268-8451-53edeb5a8773';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='一期' and PROJECT_ORIGINAL_ID='ee7ddeb5-b2f8-4d35-a0f7-3aae421ce50b';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='无分期' and PROJECT_ORIGINAL_ID='5efea5ec-882f-4b42-b078-2446227f0996';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='无分期' and PROJECT_ORIGINAL_ID='56d90a84-2e5e-4922-b2e1-208a745a80a0';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='无分期' and PROJECT_ORIGINAL_ID='c934e39d-a8e2-425b-b857-cb00c3e990a9';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='无分期' and PROJECT_ORIGINAL_ID='b425a08a-9b71-4ab3-801c-48746ac2e2dd';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='无分期' and PROJECT_ORIGINAL_ID='381c0468-7b0b-43c0-a32a-9264fafa1028';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='一期（B地块）' and PROJECT_ORIGINAL_ID='ba324993-0a98-4c10-8060-c5eecd114127';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='一期' and PROJECT_ORIGINAL_ID='fa2e5ea3-8504-4eb2-9aa5-ec7602ee919d';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='一期' and PROJECT_ORIGINAL_ID='10905db7-5420-4fc2-a99b-190f44ee1163';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='无分期' and PROJECT_ORIGINAL_ID='c1507031-f990-409b-98b3-6657ff220af7';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='一期' and PROJECT_ORIGINAL_ID='2c44c10d-2198-4007-8340-f53f4858f97f';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='无分期' and PROJECT_ORIGINAL_ID='ad2b9fbc-8636-449e-81c2-ed9aa9efbfe8';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='无分期' and PROJECT_ORIGINAL_ID='5c5140f4-667f-4302-aaec-67c7693c24f0';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='无分期' and PROJECT_ORIGINAL_ID='e6dfdb7c-3e1d-430a-a043-b51f38f2313c';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='一期' and PROJECT_ORIGINAL_ID='75db78d2-3ac1-49d5-ad23-b4dadaf8950d';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='一期' and PROJECT_ORIGINAL_ID='10479b1c-9d08-42bd-b6f7-c2a9648cf8d4';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='无分期' and PROJECT_ORIGINAL_ID='323459c0-5300-454a-b8de-a349c80de782';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='一期' and PROJECT_ORIGINAL_ID='a9d5dd4e-d359-450e-b8f6-064f49bd540e';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='无分期' and PROJECT_ORIGINAL_ID='2ff53290-3ed0-471e-82c5-0964ffd63da2';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='一期' and PROJECT_ORIGINAL_ID='ee8b3abc-84fc-40ca-91d7-94ae162af420';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='无分期' and PROJECT_ORIGINAL_ID='9697804d-6d07-4a86-ae00-4a62650c6254';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='一期' and PROJECT_ORIGINAL_ID='0a3dbbf8-261e-43a8-ab2f-7e98f0556562';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='一期' and PROJECT_ORIGINAL_ID='50af8807-b767-4fc8-b7a1-d7fc1bce9384';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='一期' and PROJECT_ORIGINAL_ID='6beaff4f-4bf8-4a42-878d-d3840d5c28d3';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='A地块一标段、二标段、B地块' and PROJECT_ORIGINAL_ID='a360fc60-8d90-3c26-e053-8606160a84f5';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='一期' and PROJECT_ORIGINAL_ID='08aa7c4e-811a-4f56-99c9-9a2feeebe226';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='无分期' and PROJECT_ORIGINAL_ID='10b61187-0e4b-4c67-b45c-11f65aa3f51c';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='一期' and PROJECT_ORIGINAL_ID='293be01c-db18-4d42-9c91-e12e94e4c508';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='无分期' and PROJECT_ORIGINAL_ID='2d26addd-6e6f-40d0-b182-1a09c1df6491';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='一期' and PROJECT_ORIGINAL_ID='a668d794-1565-48d0-89e5-cac7f404e5df';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='一期' and PROJECT_ORIGINAL_ID='a5938f5b-2a00-13a8-e053-8606160a3f88';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME='无分期' and PROJECT_ORIGINAL_ID='314f36fd-6cd6-42cc-81be-8bd8adbe2f39';
update MDM_PERIOD set is_first_open_period=1 where PERIOD_NAME in('无分期' ,'1期','一期'); 





update SYS_PROJECT_STAGE set is_first_open_period=0;
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='一期' and project_id='37233b43-b08e-4a04-a4b0-93b9bc5f3b6e';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='一期' and project_id='154758dd-a1a5-4f53-8dca-c221aae86bed';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='一期' and project_id='f4e59426-0762-4af5-ab0b-ee1a7c2d894a';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='无分期' and project_id='17879486-4345-48d1-81b9-4abd52654545';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='一期' and project_id='a3a150c7-0afc-72d1-e053-8606160afd0d';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='无分期' and project_id='3e7507a3-b76a-48c5-bd81-2820958ed919';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='无分期' and project_id='ced8e2a9-e815-4a11-a590-33bcf009ab38';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='无分期' and project_id='1daee593-2fa9-4e43-9aa6-ee820f488f0d';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='无分期' and project_id='0700e078-4fa1-41bb-baf2-e0e670176271';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='一期' and project_id='894e8218-f56a-4c35-91e1-c6e40b046eb4';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='无分期' and project_id='74678201-8f21-4c5b-98b8-265bd0d45d24';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='无分期' and project_id='e403db0f-888d-4095-ae42-fee099bb1201';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='无分期' and project_id='275faae3-d811-47f8-8d69-0a3a42901be4';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='无分期' and project_id='32dfa580-5a47-4b27-b6e9-fc9bf656872f';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='一期' and project_id='179e3f6c-26c0-46e3-8791-b535b3bb8be0';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='无分期' and project_id='a0d1ec37-fa4c-346a-e053-8606160a788a';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='无分期' and project_id='3b300bde-d6d0-4a0f-8a34-e0816e358430';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='无分期' and project_id='0f0f367a-cb20-4353-a545-73fa0b9aa67f';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='一期' and project_id='60bcaed2-668c-4e9c-ad6b-1d1116d6fb8b';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='一期' and project_id='3128727f-a9bb-4bbf-b034-630f5322f07f';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='无分期' and project_id='446d08f3-034e-4777-919f-f800124b1021';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='一期' and project_id='3fc32272-4195-48b2-894d-4d2bc80f2c6e';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='一期' and project_id='753b6304-def7-49fb-8aa6-69411f35db4b';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='无分期' and project_id='a474dd51-3783-4c07-8149-1c2b62dab8e8';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='无分期' and project_id='282e5718-7934-4a22-b3ca-f592d258fc63';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='一期' and project_id='e1b3e6ab-b881-4906-bb60-6905f3c005dd';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='住宅一期' and project_id='29a8f34c-7736-4339-bc8f-9865c63e6119';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='无分期' and project_id='9c97f412-b3f5-405b-892f-3ce6b658abce';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='无分期' and project_id='ad71a781-ad71-4959-9192-1ff6851e9d61';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='一期' and project_id='5cd38485-f4fa-4340-b156-5a6f4a090c0d';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='一期' and project_id='a4d674f1-ad4d-424a-93bd-de63db9ef715';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='一期（赵沽里地块）' and project_id='6e273234-29e6-4d03-8e16-2895b59b38cd';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='无分期' and project_id='7e06d906-77fe-4185-9606-f5fb36752d28';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='二期' and project_id='e7d9244d-3305-4ab7-a6ee-09ec206db5f7';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='无分期' and project_id='5915a7dd-59f3-45d5-ab6b-0249a943aaa0';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='无分期' and project_id='0cf75f5e-8aa6-4dad-be0f-d9f9a6993080';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='无分期' and project_id='9d73bb2f-9f25-4bd7-bfc2-629022e83604';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='无分期' and project_id='c287621c-b8bb-4ffd-af51-7ed60f3a2e54';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='无分期' and project_id='6f41511f-f86e-4f24-8d0c-48afd448340d';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='无分期' and project_id='947b093d-6cb3-4b80-a4bf-8f464cada323';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='一期' and project_id='33ee5c3d-1517-480d-a502-5d9c1d70d19c';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='无分期' and project_id='719482ac-9e56-4b7d-bfe0-2e01e0c806e4';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='无分期' and project_id='e7e8a64b-ffb3-4fb9-a876-28dbdd850aae';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='无分期' and project_id='aca43c52-082b-47df-a494-84b7ea6b9f55';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='无分期' and project_id='97e5ebfa-4c8b-47f2-99b6-b58f06a51b36';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='无分期' and project_id='1c8bc758-3d13-4c9a-834c-1123d6c4874f';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='无分期' and project_id='23730850-ea5d-44de-b980-a3bb65ab0098';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='无分期' and project_id='8ebb8dfd-ece6-448d-8caf-c9bb49c92d65';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='1期' and project_id='8b1cf7eb-ba01-44f5-8c2d-1f40d0ce8b04';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='1期' and project_id='b4a0b606-0e09-4268-8451-53edeb5a8773';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='一期' and project_id='ee7ddeb5-b2f8-4d35-a0f7-3aae421ce50b';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='无分期' and project_id='5efea5ec-882f-4b42-b078-2446227f0996';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='无分期' and project_id='56d90a84-2e5e-4922-b2e1-208a745a80a0';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='无分期' and project_id='c934e39d-a8e2-425b-b857-cb00c3e990a9';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='无分期' and project_id='b425a08a-9b71-4ab3-801c-48746ac2e2dd';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='无分期' and project_id='381c0468-7b0b-43c0-a32a-9264fafa1028';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='一期（B地块）' and project_id='ba324993-0a98-4c10-8060-c5eecd114127';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='一期' and project_id='fa2e5ea3-8504-4eb2-9aa5-ec7602ee919d';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='一期' and project_id='10905db7-5420-4fc2-a99b-190f44ee1163';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='无分期' and project_id='c1507031-f990-409b-98b3-6657ff220af7';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='一期' and project_id='2c44c10d-2198-4007-8340-f53f4858f97f';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='无分期' and project_id='ad2b9fbc-8636-449e-81c2-ed9aa9efbfe8';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='无分期' and project_id='5c5140f4-667f-4302-aaec-67c7693c24f0';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='无分期' and project_id='e6dfdb7c-3e1d-430a-a043-b51f38f2313c';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='一期' and project_id='75db78d2-3ac1-49d5-ad23-b4dadaf8950d';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='一期' and project_id='10479b1c-9d08-42bd-b6f7-c2a9648cf8d4';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='无分期' and project_id='323459c0-5300-454a-b8de-a349c80de782';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='一期' and project_id='a9d5dd4e-d359-450e-b8f6-064f49bd540e';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='无分期' and project_id='2ff53290-3ed0-471e-82c5-0964ffd63da2';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='一期' and project_id='ee8b3abc-84fc-40ca-91d7-94ae162af420';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='无分期' and project_id='9697804d-6d07-4a86-ae00-4a62650c6254';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='一期' and project_id='0a3dbbf8-261e-43a8-ab2f-7e98f0556562';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='一期' and project_id='50af8807-b767-4fc8-b7a1-d7fc1bce9384';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='一期' and project_id='6beaff4f-4bf8-4a42-878d-d3840d5c28d3';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='A地块一标段、二标段、B地块' and project_id='a360fc60-8d90-3c26-e053-8606160a84f5';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='一期' and project_id='08aa7c4e-811a-4f56-99c9-9a2feeebe226';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='无分期' and project_id='10b61187-0e4b-4c67-b45c-11f65aa3f51c';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='一期' and project_id='293be01c-db18-4d42-9c91-e12e94e4c508';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='无分期' and project_id='2d26addd-6e6f-40d0-b182-1a09c1df6491';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='一期' and project_id='a668d794-1565-48d0-89e5-cac7f404e5df';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='一期' and project_id='a5938f5b-2a00-13a8-e053-8606160a3f88';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name='无分期' and project_id='314f36fd-6cd6-42cc-81be-8bd8adbe2f39';
update SYS_PROJECT_STAGE set is_first_open_period=1 where stage_name in('无分期' ,'1期','一期');
