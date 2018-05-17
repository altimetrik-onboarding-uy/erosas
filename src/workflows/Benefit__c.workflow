<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Benefit_was_created</fullName>
        <description>Benefit was created</description>
        <protected>false</protected>
        <recipients>
            <field>Employee_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Training/Benefit_was_created</template>
    </alerts>
    <rules>
        <fullName>Benefit was created</fullName>
        <actions>
            <name>Benefit_was_created</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Benefit__c.Gross_Pay__c</field>
            <operation>greaterOrEqual</operation>
            <value>5000</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
