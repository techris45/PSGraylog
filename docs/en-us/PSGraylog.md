# PSGraylog

## Description
A Powershell Module for Graylog3 generated from it's swagger api data.

PoC-stage so a lot is going to change! Also a majority of the cmdlets is untested so take that into consideration.
But everything I've tried so far has worked.

Also, the code is not cleaned up yet and so far it's just a PoC.

But there's a lot of content already in the [docs!](docs/en-us/PSGraylog.md)

### Why not use Auto Rest?

Wanted to learn how to generate functions with Powershell code for another future project.

## Install

``` powershell

    Invoke-RestMethod https://github.com/AlexAsplund/PSGraylog/releases/download/0.0.3/PSGraylog-0.0.3.zip -OutFile .\PSGraylog-0.0.3.zip
    Expand-Archive -Path .\PSGraylog-0.0.3.zip -DestinationPath <your module dir>

```

## Usage

### Url and credentials

Easiest way is to use `Set-GLApiConfig` and your regular graylog credentials. This will set the global variables `GLApiUrl` and `GLCredential`

``` Powershell
$MyCreds = Get-Credential

# Set global variables
Set-GLApiConfig -ApiUrl 'https://graylog.contoso.com/api' -Credential $MyCreds
```

You can also use a token:

``` Powershell
# This creates a credential object with "abcdefgh12345" as username and "token" as password.
$TokenCredential = Convert-GlTokenToCredential -Token abcdefgh12345

# Set global variables
Set-GLApiConfig -ApiUrl 'https://graylog.contoso.com/api' -Credential $TokenCredential
```
### Examples
Some rudimentary documentation is included in most cmdlets: `Get-Help Get-GLCluster`

All the `Get-GL*`-commands are pretty straight forward. And if parameters are needed they're pretty self explaining.

On my todo-list is to use the type information and such from the swagger data and refine it even more.

#### Do a simple search with `Find-GLSearchRelativeSearchRelative`

Remember that this by default only returns the first 150 messages. So here we're going to fetch the first 2000 from the last hour (3600s)

``` Powershell
$Result = Find-GLSearchRelativeSearchRelative -Query "winlogbeat_winlog_event_data_TargetUserName:waldo" -Range 3600 -Limit 2000
$Result.messages
```

#### Set and Post commands with a `-Body` parameters

The Body parameter must be a `[PSCustomObject]`
Right now the documentation on how to structure the body-object is available in your api-docs (http://your-graylog/api/api-docs)

##### `Set`-method example with `Update-GLStreamAlertConditions`

First of, we need to get the `StreamId` and `ConditionId` (done quickly using `Get-GLAlertConditionsAll`)

``` Powershell
    $StreamId = "0000000000000001"
    $ConditionId = "4cb87ce0-eaba-4b3f-ada4-a7610c4be28f"

    # Object to update the AlertCondition with
    $UpdateObject = [PSCustomObject]@{
        title = 'My Test Condition'
        type = 'messagecount'
        parameters = [PSCustomObject]@{
            query = "winlogbeat_winlog_event_data_SubjectUserName:hacker"
        }
    }

    # Update the AlertCondition
    Update-GLStreamAlertConditions -StreamId $StreamId -ConditionId $ConditionId -Body $UpdateObject
    
    # *Returns the AlertConditionObject*
```

This should be pretty universal for all Update/Set/New commands with the body parameter.### [Add-GLStreamAlertsReceiver](Add-GLStreamAlertsReceiver.md)

#### Description:

Add an alert receiver

#### Example:

    Add-GLStreamAlertsReceiver -Streamid <String> -Entity <String> -Type <String>

### [Add-GLStreamOutputs](Add-GLStreamOutputs.md)

#### Description:

Associate outputs with a stream

#### Example:

    Add-GLStreamOutputs -Streamid <String> -Body <PSCustomObject>

### [Analyze-GLMessages](Analyze-GLMessages.md)

#### Description:

Analyze a message string

#### Example:

    Analyze-GLMessages -Index <String> -Analyzer <String> -String <String>

### [Cancel-GLClusterJobsJob](Cancel-GLClusterJobsJob.md)

#### Description:

Cancel job with the given ID

#### Example:

    Cancel-GLClusterJobsJob -Jobid <String>

### [Cancel-GLSystemJobs](Cancel-GLSystemJobs.md)

#### Description:

Cancel running job

#### Example:

    Cancel-GLSystemJobs -Jobid <String>

### [Close-GLIndexerIndices](Close-GLIndexerIndices.md)

#### Description:

Close an index. This will also trigger an index ranges rebuild job.

#### Example:

    Close-GLIndexerIndices -Index <String>

### [Connect-GLPipelinesConnectionsPipelines](Connect-GLPipelinesConnectionsPipelines.md)

#### Description:

Connect processing pipelines to a stream

#### Example:

    Connect-GLPipelinesConnectionsPipelines -Body <PSCustomObject>

### [Connect-GLPipelinesConnectionsStreams](Connect-GLPipelinesConnectionsStreams.md)

#### Description:

Connect streams to a processing pipeline

#### Example:

    Connect-GLPipelinesConnectionsStreams -Body <PSCustomObject>

### [Copy-GLPluginsCollectorConfigurationConfiguration](Copy-GLPluginsCollectorConfigurationConfiguration.md)

#### Description:

Copy a configuration

#### Example:

    Copy-GLPluginsCollectorConfigurationConfiguration -Id <String>

### [Copy-GLPluginsCollectorConfigurationInput](Copy-GLPluginsCollectorConfigurationInput.md)

#### Description:

Copy a configuration input

#### Example:

    Copy-GLPluginsCollectorConfigurationInput -Id <String>

### [Copy-GLPluginsCollectorConfigurationOutput](Copy-GLPluginsCollectorConfigurationOutput.md)

#### Description:

Copy a configuration output

#### Example:

    Copy-GLPluginsCollectorConfigurationOutput -Id <String>

### [Copy-GLPluginsCollectorConfigurationSnippet](Copy-GLPluginsCollectorConfigurationSnippet.md)

#### Description:

Copy a configuration snippet

#### Example:

    Copy-GLPluginsCollectorConfigurationSnippet -Id <String>

### [Copy-GLSidecarCollectorsCollector](Copy-GLSidecarCollectorsCollector.md)

#### Description:

Copy a collector

#### Example:

    Copy-GLSidecarCollectorsCollector -Id <String> -Name <String>

### [Copy-GLSidecarConfigurationsConfiguration](Copy-GLSidecarConfigurationsConfiguration.md)

#### Description:

Copy a configuration

#### Example:

    Copy-GLSidecarConfigurationsConfiguration -Id <String>

### [Copy-GLStreamsCloneStream](Copy-GLStreamsCloneStream.md)

#### Description:

Clone a stream

#### Example:

    Copy-GLStreamsCloneStream -Streamid <String> -Body <PSCustomObject>

### [Download-GLSystemContentPacksContentPackRevisions](Download-GLSystemContentPacksContentPackRevisions.md)

#### Description:

Download a revision of a content pack

#### Example:

    Download-GLSystemContentPacksContentPackRevisions -Contentpackid <String> -Revision <Int>

### [Find-GLMessagesSearch](Find-GLMessagesSearch.md)

#### Description:

Get a single message.

#### Example:

    Find-GLMessagesSearch -Index <String> -Messageid <String>

### [Find-GLSearchAbsoluteExportSearchAbsoluteChunked](Find-GLSearchAbsoluteExportSearchAbsoluteChunked.md)

#### Description:

Export message search with absolute timerange.

#### Example:

    Find-GLSearchAbsoluteExportSearchAbsoluteChunked -Query <String> -FromString <DateTime> -ToString <DateTime> -Limit <Int> -Offset <Int> -Batch_Size <Int> -Filter <String> -Fields <String>

### [Find-GLSearchAbsoluteFieldHistogramAbsolute](Find-GLSearchAbsoluteFieldHistogramAbsolute.md)

#### Description:

Field value histogram of a query using an absolute timerange.

#### Example:

    Find-GLSearchAbsoluteFieldHistogramAbsolute -Query <String> -Field <String> -Interval <String> -FromString <DateTime> -ToString <DateTime> -Filter <String> -Cardinality <Bool>

### [Find-GLSearchAbsoluteHistogramAbsolute](Find-GLSearchAbsoluteHistogramAbsolute.md)

#### Description:

Datetime histogram of a query using an absolute timerange.

#### Example:

    Find-GLSearchAbsoluteHistogramAbsolute -Query <String> -Interval <String> -FromString <DateTime> -ToString <DateTime> -Filter <String>

### [Find-GLSearchAbsoluteSearchAbsolute](Find-GLSearchAbsoluteSearchAbsolute.md)

#### Description:

Message search with absolute timerange.

#### Example:

    Find-GLSearchAbsoluteSearchAbsolute -Query <String> -FromString <DateTime> -ToString <DateTime> -Limit <Int> -Offset <Int> -Filter <String> -Fields <String> -Sort <String> -Decorate <Bool>

### [Find-GLSearchAbsoluteSearchAbsoluteChunked](Find-GLSearchAbsoluteSearchAbsoluteChunked.md)

#### Description:

Message search with absolute timerange.

#### Example:

    Find-GLSearchAbsoluteSearchAbsoluteChunked -Query <String> -FromString <DateTime> -ToString <DateTime> -Limit <Int> -Offset <Int> -Batch_Size <Int> -Filter <String> -Fields <String>

### [Find-GLSearchAbsoluteStatsAbsolute](Find-GLSearchAbsoluteStatsAbsolute.md)

#### Description:

Field statistics for a query using an absolute timerange.

#### Example:

    Find-GLSearchAbsoluteStatsAbsolute -Field <String> -Query <String> -FromString <DateTime> -ToString <DateTime> -Filter <String>

### [Find-GLSearchAbsoluteTermsAbsolute](Find-GLSearchAbsoluteTermsAbsolute.md)

#### Description:

Most common field terms of a query using an absolute timerange.

#### Example:

    Find-GLSearchAbsoluteTermsAbsolute -Field <String> -Query <String> -Stacked_Fields <String> -Size <Int> -FromString <DateTime> -ToString <DateTime> -Filter <String> -Order <String>

### [Find-GLSearchAbsoluteTermsHistogramRelative](Find-GLSearchAbsoluteTermsHistogramRelative.md)

#### Description:

Most common field terms of a query over time using an absolute timerange.

#### Example:

    Find-GLSearchAbsoluteTermsHistogramRelative -Field <String> -Query <String> -Stacked_Fields <String> -Size <Int> -FromString <DateTime> -ToString <DateTime> -Interval <String> -Filter <String> -Order <String>

### [Find-GLSearchAbsoluteTermsStatsAbsolute](Find-GLSearchAbsoluteTermsStatsAbsolute.md)

#### Description:

Ordered field terms of a query computed on another field using an absolute timerange.

#### Example:

    Find-GLSearchAbsoluteTermsStatsAbsolute -Key_Field <String> -Value_Field <String> -Order <String> -Query <String> -Size <Int> -FromString <DateTime> -ToString <DateTime> -Filter <String>

### [Find-GLSearchKeywordExportSearchKeywordChunked](Find-GLSearchKeywordExportSearchKeywordChunked.md)

#### Description:

Export message search with keyword as timerange.

#### Example:

    Find-GLSearchKeywordExportSearchKeywordChunked -Query <String> -Keyword <String> -Limit <Int> -Offset <Int> -Batch_Size <Int> -Filter <String> -Fields <String>

### [Find-GLSearchKeywordFieldHistogramKeyword](Find-GLSearchKeywordFieldHistogramKeyword.md)

#### Description:

Datetime histogram of a query using keyword timerange.

#### Example:

    Find-GLSearchKeywordFieldHistogramKeyword -Query <String> -Field <String> -Interval <String> -Keyword <String> -Filter <String> -Cardinality <Bool>

### [Find-GLSearchKeywordHistogramKeyword](Find-GLSearchKeywordHistogramKeyword.md)

#### Description:

Datetime histogram of a query using keyword timerange.

#### Example:

    Find-GLSearchKeywordHistogramKeyword -Query <String> -Interval <String> -Keyword <String> -Filter <String>

### [Find-GLSearchKeywordSearchKeyword](Find-GLSearchKeywordSearchKeyword.md)

#### Description:

Message search with keyword as timerange.

#### Example:

    Find-GLSearchKeywordSearchKeyword -Query <String> -Keyword <String> -Limit <Int> -Offset <Int> -Filter <String> -Fields <String> -Sort <String> -Decorate <Bool>

### [Find-GLSearchKeywordSearchKeywordChunked](Find-GLSearchKeywordSearchKeywordChunked.md)

#### Description:

Message search with keyword as timerange.

#### Example:

    Find-GLSearchKeywordSearchKeywordChunked -Query <String> -Keyword <String> -Limit <Int> -Offset <Int> -Batch_Size <Int> -Filter <String> -Fields <String>

### [Find-GLSearchKeywordStatsKeyword](Find-GLSearchKeywordStatsKeyword.md)

#### Description:

Field statistics for a query using a keyword timerange.

#### Example:

    Find-GLSearchKeywordStatsKeyword -Field <String> -Query <String> -Keyword <String> -Filter <String>

### [Find-GLSearchKeywordTermsHistogramRelative](Find-GLSearchKeywordTermsHistogramRelative.md)

#### Description:

Most common field terms of a query over time using a keyword timerange.

#### Example:

    Find-GLSearchKeywordTermsHistogramRelative -Field <String> -Query <String> -Stacked_Fields <String> -Size <Int> -Keyword <String> -Interval <String> -Filter <String> -Order <String>

### [Find-GLSearchKeywordTermsKeyword](Find-GLSearchKeywordTermsKeyword.md)

#### Description:

Most common field terms of a query using a keyword timerange.

#### Example:

    Find-GLSearchKeywordTermsKeyword -Field <String> -Query <String> -Stacked_Fields <String> -Size <Int> -Keyword <String> -Filter <String> -Order <String>

### [Find-GLSearchRelativeExportSearchRelativeChunked](Find-GLSearchRelativeExportSearchRelativeChunked.md)

#### Description:

Export message search with relative timerange.

#### Example:

    Find-GLSearchRelativeExportSearchRelativeChunked -Query <String> -Range <Int> -Limit <Int> -Offset <Int> -Batch_Size <Int> -Filter <String> -Fields <String>

### [Find-GLSearchRelativeFieldHistogramRelative](Find-GLSearchRelativeFieldHistogramRelative.md)

#### Description:

Field value histogram of a query using a relative timerange.

#### Example:

    Find-GLSearchRelativeFieldHistogramRelative -Query <String> -Field <String> -Interval <String> -Range <Int> -Filter <String> -Cardinality <Bool>

### [Find-GLSearchRelativeHistogramRelative](Find-GLSearchRelativeHistogramRelative.md)

#### Description:

Datetime histogram of a query using a relative timerange.

#### Example:

    Find-GLSearchRelativeHistogramRelative -Query <String> -Interval <String> -Range <Int> -Filter <String>

### [Find-GLSearchRelativeSearchRelative](Find-GLSearchRelativeSearchRelative.md)

#### Description:

Message search with relative timerange.

#### Example:

    Find-GLSearchRelativeSearchRelative -Query <String> -Range <Int> -Limit <Int> -Offset <Int> -Filter <String> -Fields <String> -Sort <String> -Decorate <Bool>

### [Find-GLSearchRelativeSearchRelativeChunked](Find-GLSearchRelativeSearchRelativeChunked.md)

#### Description:

Message search with relative timerange.

#### Example:

    Find-GLSearchRelativeSearchRelativeChunked -Query <String> -Range <Int> -Limit <Int> -Offset <Int> -Batch_Size <Int> -Filter <String> -Fields <String>

### [Find-GLSearchRelativeStatsRelative](Find-GLSearchRelativeStatsRelative.md)

#### Description:

Field statistics for a query using a relative timerange.

#### Example:

    Find-GLSearchRelativeStatsRelative -Field <String> -Query <String> -Range <Int> -Filter <String>

### [Find-GLSearchRelativeTermsHistogramRelative](Find-GLSearchRelativeTermsHistogramRelative.md)

#### Description:

Most common field terms of a query over time using a relative timerange.

#### Example:

    Find-GLSearchRelativeTermsHistogramRelative -Field <String> -Query <String> -Stacked_Fields <String> -Size <Int> -Range <Int> -Interval <String> -Filter <String> -Order <String>

### [Find-GLSearchRelativeTermsRelative](Find-GLSearchRelativeTermsRelative.md)

#### Description:

Most common field terms of a query using a relative timerange.

#### Example:

    Find-GLSearchRelativeTermsRelative -Field <String> -Query <String> -Stacked_Fields <String> -Size <Int> -Range <Int> -Filter <String> -Order <String>

### [Find-GLSystemClusterStatsElasticsearchStats](Find-GLSystemClusterStatsElasticsearchStats.md)

#### Description:

Elasticsearch information.

#### Example:

    Find-GLSystemClusterStatsElasticsearchStats

### [Get-GLAlarmCallbackHistoriesForAlert](Get-GLAlarmCallbackHistoriesForAlert.md)

#### Description:

Get a list of all alarm callbacks for this stream

#### Example:

    Get-GLAlarmCallbackHistoriesForAlert -Streamid <String> -Alertid <String>

### [Get-GLAlarmCallbacksAll](Get-GLAlarmCallbacksAll.md)

#### Description:

Get a list of all alarm callbacks

#### Example:

    Get-GLAlarmCallbacksAll

### [Get-GLAlarmCallbacksAvailable](Get-GLAlarmCallbacksAvailable.md)

#### Description:

Get a list of all alarm callbacks types

#### Example:

    Get-GLAlarmCallbacksAvailable

### [Get-GLAlertConditionsAll](Get-GLAlertConditionsAll.md)

#### Description:

Get a list of all alert conditions

#### Example:

    Get-GLAlertConditionsAll

### [Get-GLAlertConditionsAvailable](Get-GLAlertConditionsAvailable.md)

#### Description:

Get a list of all alert condition types

#### Example:

    Get-GLAlertConditionsAvailable

### [Get-GLAlerts](Get-GLAlerts.md)

#### Description:

Get an alert by ID.

#### Example:

    Get-GLAlerts -Alertid <String>

### [Get-GLAlertsPaginated](Get-GLAlertsPaginated.md)

#### Description:

Get alarms of all streams, filtered by specifying limit and offset parameters.

#### Example:

    Get-GLAlertsPaginated -Skip <Int> -Limit <Int> -State <String>

### [Get-GLAlertsRecent](Get-GLAlertsRecent.md)

#### Description:

Get the most recent alarms of all streams.

#### Example:

    Get-GLAlertsRecent -Since <Int> -Limit <Int>

### [Get-GLCluster](Get-GLCluster.md)

#### Description:

Get system overview of all Graylog nodes

#### Example:

    Get-GLCluster

### [Get-GLClusterInputState](Get-GLClusterInputState.md)

#### Description:

Get all input states

#### Example:

    Get-GLClusterInputState

### [Get-GLClusterJobs](Get-GLClusterJobs.md)

#### Description:

List currently running jobs

#### Example:

    Get-GLClusterJobs

### [Get-GLClusterJobsJob](Get-GLClusterJobsJob.md)

#### Description:

Get job with the given ID

#### Example:

    Get-GLClusterJobsJob -Jobid <String>

### [Get-GLClusterJournal](Get-GLClusterJournal.md)

#### Description:

Get message journal information of a given node

#### Example:

    Get-GLClusterJournal -Nodeid <String>

### [Get-GLClusterJvm](Get-GLClusterJvm.md)

#### Description:

Get JVM information of the given node

#### Example:

    Get-GLClusterJvm -Nodeid <String>

### [Get-GLClusterMetricsMultipleMetricsAllNodes](Get-GLClusterMetricsMultipleMetricsAllNodes.md)

#### Description:

Get all metrics of all nodes in the cluster

#### Example:

    Get-GLClusterMetricsMultipleMetricsAllNodes -RequestedMetrics <String>

### [Get-GLClusterNodeMetricsByNamespace](Get-GLClusterNodeMetricsByNamespace.md)

#### Description:

Get all metrics of a namespace from node

#### Example:

    Get-GLClusterNodeMetricsByNamespace -Nodeid <String> -Namespace <String>

### [Get-GLClusterNodeMetricsMetricNames](Get-GLClusterNodeMetricsMetricNames.md)

#### Description:

Get all metrics keys/names from node

#### Example:

    Get-GLClusterNodeMetricsMetricNames -Nodeid <String>

### [Get-GLClusterNodeMetricsMultipleMetrics](Get-GLClusterNodeMetricsMultipleMetrics.md)

#### Description:

Get the values of multiple metrics at once from node

#### Example:

    Get-GLClusterNodeMetricsMultipleMetrics -Nodeid <String> -RequestedMetrics <String>

### [Get-GLClusterPlugins](Get-GLClusterPlugins.md)

#### Description:

List all installed plugins on the given node

#### Example:

    Get-GLClusterPlugins -Nodeid <String>

### [Get-GLClusterSystemLoggersLoggers](Get-GLClusterSystemLoggersLoggers.md)

#### Description:

List all loggers of all nodes and their current levels

#### Example:

    Get-GLClusterSystemLoggersLoggers

### [Get-GLClusterSystemLoggersSubsystems](Get-GLClusterSystemLoggersSubsystems.md)

#### Description:

List all logger subsystems and their current levels

#### Example:

    Get-GLClusterSystemLoggersSubsystems

### [Get-GLClusterThreadDump](Get-GLClusterThreadDump.md)

#### Description:

Get a thread dump of the given node

#### Example:

    Get-GLClusterThreadDump -Nodeid <String>

### [Get-GLCountsTotal](Get-GLCountsTotal.md)

#### Description:

Total number of messages in all your indices.

#### Example:

    Get-GLCountsTotal -Indexsetid <String>

### [Get-GLCountsTotalAll](Get-GLCountsTotalAll.md)

#### Description:

Total number of messages in all your indices.

#### Example:

    Get-GLCountsTotalAll

### [Get-GLDashboards](Get-GLDashboards.md)

#### Description:

Get a single dashboards and all configurations of its widgets.

#### Example:

    Get-GLDashboards -Dashboardid <String>

### [Get-GLDashboardsAll](Get-GLDashboardsAll.md)

#### Description:

Get a list of all dashboards and all configurations of their widgets.

#### Example:

    Get-GLDashboardsAll

### [Get-GLDashboardsWidgetsAddWid](Get-GLDashboardsWidgetsAddWid.md)

#### Description:

Add a widget to a dashboard

#### Example:

    Get-GLDashboardsWidgetsAddWid -Dashboardid <String> -Body <PSCustomObject>

### [Get-GLDashboardsWidgetsWid](Get-GLDashboardsWidgetsWid.md)

#### Description:

Get a widget

#### Example:

    Get-GLDashboardsWidgetsWid -Dashboardid <String> -Widgetid <String>

### [Get-GLDashboardsWidgetsWidValue](Get-GLDashboardsWidgetsWidValue.md)

#### Description:

Get a single widget value.

#### Example:

    Get-GLDashboardsWidgetsWidValue -Dashboardid <String> -Widgetid <String>

### [Get-GLDocumentationOverview](Get-GLDocumentationOverview.md)

#### Description:

Get API documentation

#### Example:

    Get-GLDocumentationOverview

### [Get-GLDocumentationRoute](Get-GLDocumentationRoute.md)

#### Description:

Get detailed API documentation of a single resource

#### Example:

    Get-GLDocumentationRoute -Route <String>

### [Get-GLExtractors](Get-GLExtractors.md)

#### Description:

List all extractors of an input

#### Example:

    Get-GLExtractors -Inputid <String>

### [Get-GLExtractorsOrder](Get-GLExtractorsOrder.md)

#### Description:

Update extractor order of an input

#### Example:

    Get-GLExtractorsOrder -Inputid <String> -Body <PSCustomObject>

### [Get-GLExtractorsSingle](Get-GLExtractorsSingle.md)

#### Description:

Get information of a single extractor of an input

#### Example:

    Get-GLExtractorsSingle -Inputid <String> -Extractorid <String>

### [Get-GLIndexerClusterClusterHealth](Get-GLIndexerClusterClusterHealth.md)

#### Description:

Get cluster and shard health overview

#### Example:

    Get-GLIndexerClusterClusterHealth

### [Get-GLIndexerClusterClusterName](Get-GLIndexerClusterClusterName.md)

#### Description:

Get the cluster name

#### Example:

    Get-GLIndexerClusterClusterName

### [Get-GLIndexerFailuresSingle](Get-GLIndexerFailuresSingle.md)

#### Description:

Get a list of failed index operations.

#### Example:

    Get-GLIndexerFailuresSingle -Limit <Int> -Offset <Int>

### [Get-GLIndexerIndicesAll](Get-GLIndexerIndicesAll.md)

#### Description:

List all open, closed and reopened indices.

#### Example:

    Get-GLIndexerIndicesAll

### [Get-GLIndexerIndicesIndex](Get-GLIndexerIndicesIndex.md)

#### Description:

List all open, closed and reopened indices.

#### Example:

    Get-GLIndexerIndicesIndex -Indexsetid <String>

### [Get-GLIndexerIndicesIndexOpen](Get-GLIndexerIndicesIndexOpen.md)

#### Description:

Get information of all open indices managed by Graylog and their shards.

#### Example:

    Get-GLIndexerIndicesIndexOpen -Indexsetid <String>

### [Get-GLIndexerIndicesMultiple](Get-GLIndexerIndicesMultiple.md)

#### Description:

Get information of all specified indices and their shards.

#### Example:

    Get-GLIndexerIndicesMultiple -RequestedIndices <String>

### [Get-GLIndexerIndicesOpen](Get-GLIndexerIndicesOpen.md)

#### Description:

Get information of all open indices managed by Graylog and their shards.

#### Example:

    Get-GLIndexerIndicesOpen

### [Get-GLIndexerIndicesSingle](Get-GLIndexerIndicesSingle.md)

#### Description:

Get information of an index and its shards.

#### Example:

    Get-GLIndexerIndicesSingle -Index <String>

### [Get-GLIndexerIndicesTemplates](Get-GLIndexerIndicesTemplates.md)

#### Description:

Get index template for the given index set

#### Example:

    Get-GLIndexerIndicesTemplates -Indexsetid <String>

### [Get-GLIndexerIndicesTemplatesAll](Get-GLIndexerIndicesTemplatesAll.md)

#### Description:

Get index templates for all index sets

#### Example:

    Get-GLIndexerIndicesTemplatesAll

### [Get-GLIndexerOverviewIndex](Get-GLIndexerOverviewIndex.md)

#### Description:

Get overview of current indexing state for the given index set, including deflector config, cluster state, index ranges & message counts.

#### Example:

    Get-GLIndexerOverviewIndex -Indexsetid <String>

### [Get-GLIndexerOverviewIndexAll](Get-GLIndexerOverviewIndexAll.md)

#### Description:

Get overview of current indexing state, including deflector config, cluster state, index ranges & message counts.

#### Example:

    Get-GLIndexerOverviewIndexAll

### [Get-GLMapWidgetMapData](Get-GLMapWidgetMapData.md)

#### Description:

Get map data

#### Example:

    Get-GLMapWidgetMapData -Body <PSCustomObject>

### [Get-GLPipelinesConnectionsAll](Get-GLPipelinesConnectionsAll.md)

#### Description:

Get all pipeline connections

#### Example:

    Get-GLPipelinesConnectionsAll

### [Get-GLPipelinesConnectionsPipelinesForStream](Get-GLPipelinesConnectionsPipelinesForStream.md)

#### Description:

Get pipeline connections for the given stream

#### Example:

    Get-GLPipelinesConnectionsPipelinesForStream -Streamid <String>

### [Get-GLPipelinesPipelines](Get-GLPipelinesPipelines.md)

#### Description:

Get a processing pipeline

#### Example:

    Get-GLPipelinesPipelines -Id <String>

### [Get-GLPipelinesPipelinesAll](Get-GLPipelinesPipelinesAll.md)

#### Description:

Get all processing pipelines

#### Example:

    Get-GLPipelinesPipelinesAll

### [Get-GLPipelinesRules](Get-GLPipelinesRules.md)

#### Description:

Get a processing rule

#### Example:

    Get-GLPipelinesRules -Id <String>

### [Get-GLPipelinesRulesAll](Get-GLPipelinesRulesAll.md)

#### Description:

Get all processing rules

#### Example:

    Get-GLPipelinesRulesAll

### [Get-GLPipelinesRulesBulk](Get-GLPipelinesRulesBulk.md)

#### Description:

Retrieve the named processing rules in bulk

#### Example:

    Get-GLPipelinesRulesBulk -Body <String>

### [Get-GLPipelinesRulesFunctionDescriptors](Get-GLPipelinesRulesFunctionDescriptors.md)

#### Description:

Get function descriptors

#### Example:

    Get-GLPipelinesRulesFunctionDescriptors

### [Get-GLPluginsCollectorConfigurationConfiguration](Get-GLPluginsCollectorConfigurationConfiguration.md)

#### Description:

Get a single collector configuration

#### Example:

    Get-GLPluginsCollectorConfigurationConfiguration -Collectorid <String> -Tags <String>

### [Get-GLPluginsCollectorConfigurationConfigurations](Get-GLPluginsCollectorConfigurationConfigurations.md)

#### Description:

Show collector configuration details

#### Example:

    Get-GLPluginsCollectorConfigurationConfigurations -Id <String>

### [Get-GLPluginsCollectorConfigurationConfigurationsAll](Get-GLPluginsCollectorConfigurationConfigurationsAll.md)

#### Description:

List all collector configurations

#### Example:

    Get-GLPluginsCollectorConfigurationConfigurationsAll

### [Get-GLPluginsCollectorConfigurationTags](Get-GLPluginsCollectorConfigurationTags.md)

#### Description:

List all used tags

#### Example:

    Get-GLPluginsCollectorConfigurationTags

### [Get-GLPluginsSystemCollectors](Get-GLPluginsSystemCollectors.md)

#### Description:

Returns at most one collector summary for the specified collector id

#### Example:

    Get-GLPluginsSystemCollectors -Collectorid <String>

### [Get-GLPluginsSystemCollectorsAction](Get-GLPluginsSystemCollectorsAction.md)

#### Description:

Returns queued actions for the specified collector id

#### Example:

    Get-GLPluginsSystemCollectorsAction -Collectorid <String>

### [Get-GLPluginsSystemCollectorsAll](Get-GLPluginsSystemCollectorsAll.md)

#### Description:

Lists all existing collector registrations

#### Example:

    Get-GLPluginsSystemCollectorsAll

### [Get-GLRolesAll](Get-GLRolesAll.md)

#### Description:

List all roles

#### Example:

    Get-GLRolesAll

### [Get-GLRolesMembers](Get-GLRolesMembers.md)

#### Description:

Retrieve the role's members

#### Example:

    Get-GLRolesMembers -Rolename <String>

### [Get-GLRolesRead](Get-GLRolesRead.md)

#### Description:

Retrieve permissions for a single role

#### Example:

    Get-GLRolesRead -Rolename <String>

### [Get-GLSearchDecorators](Get-GLSearchDecorators.md)

#### Description:

Returns all configured message decorations

#### Example:

    Get-GLSearchDecorators

### [Get-GLSearchDecoratorsAvailable](Get-GLSearchDecoratorsAvailable.md)

#### Description:

Returns all available message decorations

#### Example:

    Get-GLSearchDecoratorsAvailable

### [Get-GLSearchKeywordTermsStatsRelative](Get-GLSearchKeywordTermsStatsRelative.md)

#### Description:

Ordered field terms of a query computed on another field using a keyword timerange.

#### Example:

    Get-GLSearchKeywordTermsStatsRelative -Key_Field <String> -Value_Field <String> -Order <String> -Query <String> -Size <Int> -Keyword <String> -Filter <String>

### [Get-GLSearchRelativeTermsStatsRelative](Get-GLSearchRelativeTermsStatsRelative.md)

#### Description:

Ordered field terms of a query computed on another field using a relative timerange.

#### Example:

    Get-GLSearchRelativeTermsStatsRelative -Key_Field <String> -Value_Field <String> -Order <String> -Query <String> -Size <Int> -Range <Int> -Filter <String>

### [Get-GLSearchSaved](Get-GLSearchSaved.md)

#### Description:

Get a single saved search

#### Example:

    Get-GLSearchSaved -Searchid <String>

### [Get-GLSearchSavedAll](Get-GLSearchSavedAll.md)

#### Description:

Get a list of all saved searches

#### Example:

    Get-GLSearchSavedAll

### [Get-GLSidecar](Get-GLSidecar.md)

#### Description:

Returns at most one Sidecar summary for the specified id

#### Example:

    Get-GLSidecar -Sidecarid <String>

### [Get-GLSidecarAdministrationAdministration](Get-GLSidecarAdministrationAdministration.md)

#### Description:

Lists existing Sidecar registrations including compatible sidecars using pagination

#### Example:

    Get-GLSidecarAdministrationAdministration -Body <PSCustomObject>

### [Get-GLSidecarAll](Get-GLSidecarAll.md)

#### Description:

Lists all existing Sidecar registrations

#### Example:

    Get-GLSidecarAll

### [Get-GLSidecarCollectorActionsAction](Get-GLSidecarCollectorActionsAction.md)

#### Description:

Returns queued actions for the specified Sidecar id

#### Example:

    Get-GLSidecarCollectorActionsAction -Sidecarid <String>

### [Get-GLSidecarCollectorsCollector](Get-GLSidecarCollectorsCollector.md)

#### Description:

Show collector details

#### Example:

    Get-GLSidecarCollectorsCollector -Id <String>

### [Get-GLSidecarCollectorsCollectors](Get-GLSidecarCollectorsCollectors.md)

#### Description:

List all collectors

#### Example:

    Get-GLSidecarCollectorsCollectors

### [Get-GLSidecarCollectorsSummary](Get-GLSidecarCollectorsSummary.md)

#### Description:

List a summary of all collectors

#### Example:

    Get-GLSidecarCollectorsSummary -Page <Int> -Per_Page <Int> -Query <String> -Sort <String> -Order <String>

### [Get-GLSidecarConfigurationsConfigurations](Get-GLSidecarConfigurationsConfigurations.md)

#### Description:

Show configuration details

#### Example:

    Get-GLSidecarConfigurationsConfigurations -Id <String>

### [Get-GLSidecarConfigurationsConfigurationsAll](Get-GLSidecarConfigurationsConfigurationsAll.md)

#### Description:

List all configurations

#### Example:

    Get-GLSidecarConfigurationsConfigurationsAll -Page <Int> -Per_Page <Int> -Query <String> -Sort <String> -Order <String>

### [Get-GLSidecarConfigurationsConfigurationSidecars](Get-GLSidecarConfigurationsConfigurationSidecars.md)

#### Description:

Show sidecars using the given configuration

#### Example:

    Get-GLSidecarConfigurationsConfigurationSidecars -Id <String>

### [Get-GLSidecarConfigurationsImports](Get-GLSidecarConfigurationsImports.md)

#### Description:

List all uploaded configurations

#### Example:

    Get-GLSidecarConfigurationsImports -Page <Int>

### [Get-GLSidecarConfigurationsRenderConfiguration](Get-GLSidecarConfigurationsRenderConfiguration.md)

#### Description:

Render configuration template

#### Example:

    Get-GLSidecarConfigurationsRenderConfiguration -Sidecarid <String> -Configurationid <String>

### [Get-GLSidecarConfigurationsRenderConfigurationAll](Get-GLSidecarConfigurationsRenderConfigurationAll.md)

#### Description:

Render preview of a configuration template

#### Example:

    Get-GLSidecarConfigurationsRenderConfigurationAll -Body <PSCustomObject>

### [Get-GLSidecarConfigurationVariablesConfigurationVariables](Get-GLSidecarConfigurationVariablesConfigurationVariables.md)

#### Description:

List all configuration variables

#### Example:

    Get-GLSidecarConfigurationVariablesConfigurationVariables

### [Get-GLSidecarConfigurationVariablesConfigurationVariablesConfigurations](Get-GLSidecarConfigurationVariablesConfigurationVariablesConfigurations.md)

#### Description:

Show configurations using this variable

#### Example:

    Get-GLSidecarConfigurationVariablesConfigurationVariablesConfigurations -Id <String>

### [Get-GLSidecarSidecars](Get-GLSidecarSidecars.md)

#### Description:

Lists existing Sidecar registrations using pagination

#### Example:

    Get-GLSidecarSidecars -Page <Int> -Per_Page <Int> -Query <String> -Sort <String> -Order <String> -Only_Active <Bool>

### [Get-GLSources](Get-GLSources.md)

#### Description:

Get a list of all sources (not more than 5000) that have messages in the current indices. The result is cached for 10 seconds.

#### Example:

    Get-GLSources -Range <Int> -Size <Int>

### [Get-GLStreamAlarmCallbacks](Get-GLStreamAlarmCallbacks.md)

#### Description:

Get a single specified alarm callback for this stream

#### Example:

    Get-GLStreamAlarmCallbacks -Streamid <String> -Alarmcallbackid <String>

### [Get-GLStreamAlarmCallbacksAll](Get-GLStreamAlarmCallbacksAll.md)

#### Description:

Get a list of all alarm callbacks for this stream

#### Example:

    Get-GLStreamAlarmCallbacksAll -Streamid <String>

### [Get-GLStreamAlarmCallbacksAvailable](Get-GLStreamAlarmCallbacksAvailable.md)

#### Description:

Get a list of all alarm callback types

#### Example:

    Get-GLStreamAlarmCallbacksAvailable -Streamid <String>

### [Get-GLStreamAlertConditions](Get-GLStreamAlertConditions.md)

#### Description:

Get an alert condition

#### Example:

    Get-GLStreamAlertConditions -Streamid <String> -Conditionid <String>

### [Get-GLStreamAlertConditionsAll](Get-GLStreamAlertConditionsAll.md)

#### Description:

Get all alert conditions of this stream

#### Example:

    Get-GLStreamAlertConditionsAll -Streamid <String>

### [Get-GLStreamAlerts](Get-GLStreamAlerts.md)

#### Description:

Get the most recent alarms of this stream.

#### Example:

    Get-GLStreamAlerts -Streamid <String> -Since <Int> -Limit <Int>

### [Get-GLStreamAlertsPaginated](Get-GLStreamAlertsPaginated.md)

#### Description:

Get the alarms of this stream, filtered by specifying limit and offset parameters.

#### Example:

    Get-GLStreamAlertsPaginated -Streamid <String> -Skip <Int> -Limit <Int> -State <String>

### [Get-GLStreamOutputs](Get-GLStreamOutputs.md)

#### Description:

Get specific output of a stream

#### Example:

    Get-GLStreamOutputs -Streamid <String> -Outputid <String>

### [Get-GLStreamOutputsAll](Get-GLStreamOutputsAll.md)

#### Description:

Get a list of all outputs for a stream

#### Example:

    Get-GLStreamOutputsAll -Streamid <String>

### [Get-GLStreamRules](Get-GLStreamRules.md)

#### Description:

Get a single stream rules

#### Example:

    Get-GLStreamRules -Streamid <String> -Streamruleid <String>

### [Get-GLStreamRulesAll](Get-GLStreamRulesAll.md)

#### Description:

Get a list of all stream rules

#### Example:

    Get-GLStreamRulesAll -Streamid <String>

### [Get-GLStreamRulesTypes](Get-GLStreamRulesTypes.md)

#### Description:

Get all available stream types

#### Example:

    Get-GLStreamRulesTypes -Streamid <String>

### [Get-GLStreams](Get-GLStreams.md)

#### Description:

Get a single stream

#### Example:

    Get-GLStreams -Streamid <String>

### [Get-GLStreamsAll](Get-GLStreamsAll.md)

#### Description:

Get a list of all streams

#### Example:

    Get-GLStreamsAll

### [Get-GLStreamsEnabled](Get-GLStreamsEnabled.md)

#### Description:

Get a list of all enabled streams

#### Example:

    Get-GLStreamsEnabled

### [Get-GLSystemAuthenticationAuthenticators](Get-GLSystemAuthenticationAuthenticators.md)

#### Description:

Retrieve authentication providers configuration

#### Example:

    Get-GLSystemAuthenticationAuthenticators

### [Get-GLSystemCatalogShowEntityIndex](Get-GLSystemCatalogShowEntityIndex.md)

#### Description:

List available entities in this Graylog cluster

#### Example:

    Get-GLSystemCatalogShowEntityIndex

### [Get-GLSystemClusterConfig](Get-GLSystemClusterConfig.md)

#### Description:

List all configuration classes

#### Example:

    Get-GLSystemClusterConfig

### [Get-GLSystemClusterConfigRead](Get-GLSystemClusterConfigRead.md)

#### Description:

Get configuration settings from database

#### Example:

    Get-GLSystemClusterConfigRead -Configclass <String>

### [Get-GLSystemClusterConfigSchema](Get-GLSystemClusterConfigSchema.md)

#### Description:

Get JSON schema of configuration class

#### Example:

    Get-GLSystemClusterConfigSchema -Configclass <String>

### [Get-GLSystemClusterNode](Get-GLSystemClusterNode.md)

#### Description:

Information about a node.

#### Example:

    Get-GLSystemClusterNode -Nodeid <String>

### [Get-GLSystemClusterNodeAll](Get-GLSystemClusterNodeAll.md)

#### Description:

Information about this node.

#### Example:

    Get-GLSystemClusterNodeAll

### [Get-GLSystemClusterNodes](Get-GLSystemClusterNodes.md)

#### Description:

List all active nodes in this cluster.

#### Example:

    Get-GLSystemClusterNodes

### [Get-GLSystemClusterStatsMongoStats](Get-GLSystemClusterStatsMongoStats.md)

#### Description:

MongoDB information.

#### Example:

    Get-GLSystemClusterStatsMongoStats

### [Get-GLSystemClusterStatsSystemStats](Get-GLSystemClusterStatsSystemStats.md)

#### Description:

Cluster status information.

#### Example:

    Get-GLSystemClusterStatsSystemStats

### [Get-GLSystemClusterTraffic](Get-GLSystemClusterTraffic.md)

#### Description:

Get the cluster traffic stats

#### Example:

    Get-GLSystemClusterTraffic -Days <Int> -Daily <Bool>

### [Get-GLSystemCodecsTypesAll](Get-GLSystemCodecsTypesAll.md)

#### Description:

Get all codec types

#### Example:

    Get-GLSystemCodecsTypesAll

### [Get-GLSystemConfigurationRelevant](Get-GLSystemConfigurationRelevant.md)

#### Description:

Get relevant configuration settings and their values

#### Example:

    Get-GLSystemConfigurationRelevant

### [Get-GLSystemContentPacksContentPackInstallationsById](Get-GLSystemContentPacksContentPackInstallationsById.md)

#### Description:

Get details about the installations of a content pack

#### Example:

    Get-GLSystemContentPacksContentPackInstallationsById -Contentpackid <String>

### [Get-GLSystemContentPacksContentPackRevisions](Get-GLSystemContentPacksContentPackRevisions.md)

#### Description:

Get a revision of a content pack

#### Example:

    Get-GLSystemContentPacksContentPackRevisions -Contentpackid <String> -Revision <Int>

### [Get-GLSystemContentPacksContentPackRevisionsAll](Get-GLSystemContentPacksContentPackRevisionsAll.md)

#### Description:

List all revisions of a content pack

#### Example:

    Get-GLSystemContentPacksContentPackRevisionsAll -Contentpackid <String>

### [Get-GLSystemContentPacksContentPacks](Get-GLSystemContentPacksContentPacks.md)

#### Description:

List available content packs

#### Example:

    Get-GLSystemContentPacksContentPacks

### [Get-GLSystemContentPacksLatestContentPacks](Get-GLSystemContentPacksLatestContentPacks.md)

#### Description:

List latest available content packs

#### Example:

    Get-GLSystemContentPacksLatestContentPacks

### [Get-GLSystemContentPacksUninstallDetails](Get-GLSystemContentPacksUninstallDetails.md)

#### Description:

Get details about which entities will actually be uninstalled

#### Example:

    Get-GLSystemContentPacksUninstallDetails -Contentpackid <String> -Installationid <String>

### [Get-GLSystemDebugEventsShowLastClusterDebugEvent](Get-GLSystemDebugEventsShowLastClusterDebugEvent.md)

#### Description:

Show last received cluster debug event.

#### Example:

    Get-GLSystemDebugEventsShowLastClusterDebugEvent

### [Get-GLSystemDebugEventsShowLastDebugEvent](Get-GLSystemDebugEventsShowLastDebugEvent.md)

#### Description:

Show last received local debug event.

#### Example:

    Get-GLSystemDebugEventsShowLastDebugEvent

### [Get-GLSystemDeflectorDeflector](Get-GLSystemDeflectorDeflector.md)

#### Description:

Get current deflector status in index set

#### Example:

    Get-GLSystemDeflectorDeflector -Indexsetid <String>

### [Get-GLSystemDeflectorDeprecatedDeflector](Get-GLSystemDeflectorDeprecatedDeflector.md)

#### Description:

Get current deflector status

#### Example:

    Get-GLSystemDeflectorDeprecatedDeflector

### [Get-GLSystemFieldsFields](Get-GLSystemFieldsFields.md)

#### Description:

Get list of message fields that exist

#### Example:

    Get-GLSystemFieldsFields -Limit <Int>

### [Get-GLSystemGettingStartedGuidesDismisstingStarted](Get-GLSystemGettingStartedGuidesDismisstingStarted.md)

#### Description:

Dismiss auto-showing getting started guide for this version

#### Example:

    Get-GLSystemGettingStartedGuidesDismisstingStarted

### [Get-GLSystemGettingStartedGuidesDisplaytingStarted](Get-GLSystemGettingStartedGuidesDisplaytingStarted.md)

#### Description:

Check whether to display the Getting started guide for this version

#### Example:

    Get-GLSystemGettingStartedGuidesDisplaytingStarted

### [Get-GLSystemGrokGrokPatterns](Get-GLSystemGrokGrokPatterns.md)

#### Description:

Get all existing grok patterns

#### Example:

    Get-GLSystemGrokGrokPatterns

### [Get-GLSystemGrokPattern](Get-GLSystemGrokPattern.md)

#### Description:

Get the existing grok pattern

#### Example:

    Get-GLSystemGrokPattern -Patternid <String>

### [Get-GLSystemIndexRanges](Get-GLSystemIndexRanges.md)

#### Description:

Get a list of all index ranges

#### Example:

    Get-GLSystemIndexRanges

### [Get-GLSystemIndexRangesRebuild](Get-GLSystemIndexRangesRebuild.md)

#### Description:

Rebuild/sync index range information.

#### Example:

    Get-GLSystemIndexRangesRebuild

### [Get-GLSystemIndexRangesRebuildIndex](Get-GLSystemIndexRangesRebuildIndex.md)

#### Description:

Rebuild/sync index range information.

#### Example:

    Get-GLSystemIndexRangesRebuildIndex -Index <String>

### [Get-GLSystemIndexRangesShow](Get-GLSystemIndexRangesShow.md)

#### Description:

Show single index range

#### Example:

    Get-GLSystemIndexRangesShow -Index <String>

### [Get-GLSystemIndexSets](Get-GLSystemIndexSets.md)

#### Description:

Get index set

#### Example:

    Get-GLSystemIndexSets -Id <String>

### [Get-GLSystemIndexSetsAll](Get-GLSystemIndexSetsAll.md)

#### Description:

Get a list of all index sets

#### Example:

    Get-GLSystemIndexSetsAll -Skip <Int> -Limit <Int> -Stats <Bool>

### [Get-GLSystemIndexSetsGlobalStats](Get-GLSystemIndexSetsGlobalStats.md)

#### Description:

Get stats of all index sets

#### Example:

    Get-GLSystemIndexSetsGlobalStats

### [Get-GLSystemIndexSetsIndexStatistics](Get-GLSystemIndexSetsIndexStatistics.md)

#### Description:

Get index set statistics

#### Example:

    Get-GLSystemIndexSetsIndexStatistics -Id <String>

### [Get-GLSystemIndicesRetention](Get-GLSystemIndicesRetention.md)

#### Description:

List available retention strategies

#### Example:

    Get-GLSystemIndicesRetention

### [Get-GLSystemIndicesRetentionConfigSchema](Get-GLSystemIndicesRetentionConfigSchema.md)

#### Description:

Show JSON schema for configuration of given retention strategies

#### Example:

    Get-GLSystemIndicesRetentionConfigSchema -Strategy <String>

### [Get-GLSystemIndicesRotation](Get-GLSystemIndicesRotation.md)

#### Description:

List available rotation strategies

#### Example:

    Get-GLSystemIndicesRotation

### [Get-GLSystemIndicesRotationConfigSchema](Get-GLSystemIndicesRotationConfigSchema.md)

#### Description:

Show JSON schema for configuration of given rotation strategies

#### Example:

    Get-GLSystemIndicesRotationConfigSchema -Strategy <String>

### [Get-GLSystemInputs](Get-GLSystemInputs.md)

#### Description:

Get information of a single input on this node

#### Example:

    Get-GLSystemInputs -Inputid <String>

### [Get-GLSystemInputsAll](Get-GLSystemInputsAll.md)

#### Description:

Get all inputs

#### Example:

    Get-GLSystemInputsAll

### [Get-GLSystemInputStates](Get-GLSystemInputStates.md)

#### Description:

Get input state for specified input id on this node

#### Example:

    Get-GLSystemInputStates -Inputid <String>

### [Get-GLSystemInputStatesAll](Get-GLSystemInputStatesAll.md)

#### Description:

Get all input states of this node

#### Example:

    Get-GLSystemInputStatesAll

### [Get-GLSystemInputsTypesAll](Get-GLSystemInputsTypesAll.md)

#### Description:

Get information about all input types

#### Example:

    Get-GLSystemInputsTypesAll

### [Get-GLSystemInputsTypesInfo](Get-GLSystemInputsTypesInfo.md)

#### Description:

Get information about a single input type

#### Example:

    Get-GLSystemInputsTypesInfo -Inputtype <String>

### [Get-GLSystemInputsTypesTypes](Get-GLSystemInputsTypesTypes.md)

#### Description:

Get all available input types of this node

#### Example:

    Get-GLSystemInputsTypesTypes

### [Get-GLSystemJobs](Get-GLSystemJobs.md)

#### Description:

Get information of a specific currently running job

#### Example:

    Get-GLSystemJobs -Jobid <String>

### [Get-GLSystemJobsAll](Get-GLSystemJobsAll.md)

#### Description:

List currently running jobs

#### Example:

    Get-GLSystemJobsAll

### [Get-GLSystemJournalShow](Get-GLSystemJournalShow.md)

#### Description:

Get current state of the journal on this node.

#### Example:

    Get-GLSystemJournalShow

### [Get-GLSystemJvm](Get-GLSystemJvm.md)

#### Description:

Get JVM information

#### Example:

    Get-GLSystemJvm

### [Get-GLSystemLDAPLdaptings](Get-GLSystemLDAPLdaptings.md)

#### Description:

Get the LDAP configuration if it is configured

#### Example:

    Get-GLSystemLDAPLdaptings

### [Get-GLSystemLDAPReadGroupMapping](Get-GLSystemLDAPReadGroupMapping.md)

#### Description:

Get the LDAP group to Graylog role mapping

#### Example:

    Get-GLSystemLDAPReadGroupMapping

### [Get-GLSystemLDAPReadGroups](Get-GLSystemLDAPReadGroups.md)

#### Description:

Get the available LDAP groups

#### Example:

    Get-GLSystemLDAPReadGroups

### [Get-GLSystemLoadBalancersStatus](Get-GLSystemLoadBalancersStatus.md)

#### Description:

Get status of this Graylog server node for load balancers. Returns ALIVE with HTTP 200, DEAD with HTTP 503, or THROTTLED with HTTP 429.

#### Example:

    Get-GLSystemLoadBalancersStatus

### [Get-GLSystemLocales](Get-GLSystemLocales.md)

#### Description:

Get supported locales

#### Example:

    Get-GLSystemLocales

### [Get-GLSystemLoggersLoggers](Get-GLSystemLoggersLoggers.md)

#### Description:

List all loggers and their current levels

#### Example:

    Get-GLSystemLoggersLoggers

### [Get-GLSystemLoggersMessages](Get-GLSystemLoggersMessages.md)

#### Description:

Get recent internal log messages

#### Example:

    Get-GLSystemLoggersMessages -Limit <Int> -Level <String>

### [Get-GLSystemLoggersSubsystems](Get-GLSystemLoggersSubsystems.md)

#### Description:

List all logger subsystems and their current levels

#### Example:

    Get-GLSystemLoggersSubsystems

### [Get-GLSystemLookup](Get-GLSystemLookup.md)

#### Description:

Retrieve the named lookup table

#### Example:

    Get-GLSystemLookup -Idorname <String> -Resolve <Bool>

### [Get-GLSystemLookupAdapter](Get-GLSystemLookupAdapter.md)

#### Description:

List the given data adapter

#### Example:

    Get-GLSystemLookupAdapter -Idorname <String>

### [Get-GLSystemLookupAdapters](Get-GLSystemLookupAdapters.md)

#### Description:

List available data adapters

#### Example:

    Get-GLSystemLookupAdapters -Page <Int> -Per_Page <Int> -Sort <String> -Order <String> -Query <String>

### [Get-GLSystemLookupAvailableAdapterTypes](Get-GLSystemLookupAvailableAdapterTypes.md)

#### Description:

List available data adapter types

#### Example:

    Get-GLSystemLookupAvailableAdapterTypes

### [Get-GLSystemLookupAvailableCacheTypes](Get-GLSystemLookupAvailableCacheTypes.md)

#### Description:

List available caches types

#### Example:

    Get-GLSystemLookupAvailableCacheTypes

### [Get-GLSystemLookupCache](Get-GLSystemLookupCache.md)

#### Description:

List the given cache

#### Example:

    Get-GLSystemLookupCache -Idorname <String>

### [Get-GLSystemLookupCaches](Get-GLSystemLookupCaches.md)

#### Description:

List available caches

#### Example:

    Get-GLSystemLookupCaches -Page <Int> -Per_Page <Int> -Sort <String> -Order <String> -Query <String>

### [Get-GLSystemLookupErrorStates](Get-GLSystemLookupErrorStates.md)

#### Description:

Retrieve the runtime error states of the given lookup tables, caches and adapters

#### Example:

    Get-GLSystemLookupErrorStates -Request <String>

### [Get-GLSystemLookupTables](Get-GLSystemLookupTables.md)

#### Description:

List configured lookup tables

#### Example:

    Get-GLSystemLookupTables -Page <Int> -Per_Page <Int> -Sort <String> -Order <String> -Query <String> -Resolve <Bool>

### [Get-GLSystemMessageProcessorsConfig](Get-GLSystemMessageProcessorsConfig.md)

#### Description:

Get message processor configuration

#### Example:

    Get-GLSystemMessageProcessorsConfig

### [Get-GLSystemMessagesAll](Get-GLSystemMessagesAll.md)

#### Description:

Get internal Graylog system messages

#### Example:

    Get-GLSystemMessagesAll -Page <Int>

### [Get-GLSystemMetricsByNamespace](Get-GLSystemMetricsByNamespace.md)

#### Description:

Get all metrics of a namespace

#### Example:

    Get-GLSystemMetricsByNamespace -Namespace <String>

### [Get-GLSystemMetricsHistoryHistoricSingleMetric](Get-GLSystemMetricsHistoryHistoricSingleMetric.md)

#### Description:

Get history of a single metric

#### Example:

    Get-GLSystemMetricsHistoryHistoricSingleMetric -Metricname <String> -After <String>

### [Get-GLSystemMetricsMetricNames](Get-GLSystemMetricsMetricNames.md)

#### Description:

Get all metrics keys/names

#### Example:

    Get-GLSystemMetricsMetricNames

### [Get-GLSystemMetricsMetrics](Get-GLSystemMetricsMetrics.md)

#### Description:

Get all metrics

#### Example:

    Get-GLSystemMetricsMetrics

### [Get-GLSystemMetricsMultipleMetrics](Get-GLSystemMetricsMultipleMetrics.md)

#### Description:

Get the values of multiple metrics at once

#### Example:

    Get-GLSystemMetricsMultipleMetrics -RequestedMetrics <String>

### [Get-GLSystemMetricsSingleMetric](Get-GLSystemMetricsSingleMetric.md)

#### Description:

Get a single metric

#### Example:

    Get-GLSystemMetricsSingleMetric -Metricname <String>

### [Get-GLSystemNotificationsNotifications](Get-GLSystemNotificationsNotifications.md)

#### Description:

Get all active notifications

#### Example:

    Get-GLSystemNotificationsNotifications

### [Get-GLSystemOutputs](Get-GLSystemOutputs.md)

#### Description:

Get specific output

#### Example:

    Get-GLSystemOutputs -Outputid <String>

### [Get-GLSystemOutputsAll](Get-GLSystemOutputsAll.md)

#### Description:

Get a list of all outputs

#### Example:

    Get-GLSystemOutputsAll

### [Get-GLSystemOutputsAvailable](Get-GLSystemOutputsAvailable.md)

#### Description:

Get all available output modules

#### Example:

    Get-GLSystemOutputsAvailable

### [Get-GLSystemPermissionsPermissions](Get-GLSystemPermissionsPermissions.md)

#### Description:

Get all available user permissions.

#### Example:

    Get-GLSystemPermissionsPermissions

### [Get-GLSystemPermissionsReaderPermissions](Get-GLSystemPermissionsReaderPermissions.md)

#### Description:

Get the initial permissions assigned to a reader account

#### Example:

    Get-GLSystemPermissionsReaderPermissions -Username <String>

### [Get-GLSystemPlugins](Get-GLSystemPlugins.md)

#### Description:

List all installed plugins on this node.

#### Example:

    Get-GLSystemPlugins

### [Get-GLSystemServiceManager](Get-GLSystemServiceManager.md)

#### Description:

List current status of ServiceManager

#### Example:

    Get-GLSystemServiceManager

### [Get-GLSystemStatsFsStats](Get-GLSystemStatsFsStats.md)

#### Description:

Filesystem information about this node.

#### Example:

    Get-GLSystemStatsFsStats

### [Get-GLSystemStatsJvmStats](Get-GLSystemStatsJvmStats.md)

#### Description:

JVM information about this node.

#### Example:

    Get-GLSystemStatsJvmStats

### [Get-GLSystemStatsNetworkStats](Get-GLSystemStatsNetworkStats.md)

#### Description:

Networking information about this node.

#### Example:

    Get-GLSystemStatsNetworkStats

### [Get-GLSystemStatsOsStats](Get-GLSystemStatsOsStats.md)

#### Description:

OS information about this node.

#### Example:

    Get-GLSystemStatsOsStats

### [Get-GLSystemStatsProcessStats](Get-GLSystemStatsProcessStats.md)

#### Description:

Process information about this node.

#### Example:

    Get-GLSystemStatsProcessStats

### [Get-GLSystemStatsSystemStats](Get-GLSystemStatsSystemStats.md)

#### Description:

System information about this node.

#### Example:

    Get-GLSystemStatsSystemStats

### [Get-GLSystemSystem](Get-GLSystemSystem.md)

#### Description:

Get system overview

#### Example:

    Get-GLSystemSystem

### [Get-GLSystemThreaddump](Get-GLSystemThreaddump.md)

#### Description:

Get a thread dump

#### Example:

    Get-GLSystemThreaddump

### [Get-GLSystemThreadDumpAsText](Get-GLSystemThreadDumpAsText.md)

#### Description:

Get a thread dump as plain text

#### Example:

    Get-GLSystemThreadDumpAsText

### [Get-GLSystemThroughputTotal](Get-GLSystemThroughputTotal.md)

#### Description:

Current throughput of this node in messages per second

#### Example:

    Get-GLSystemThroughputTotal

### [Get-GLUsers](Get-GLUsers.md)

#### Description:

Get user details

#### Example:

    Get-GLUsers -Username <String>

### [Get-GLUsersTokens](Get-GLUsersTokens.md)

#### Description:

Retrieves the list of access tokens for a user

#### Example:

    Get-GLUsersTokens -Username <String>

### [Get-GLUsersUsers](Get-GLUsersUsers.md)

#### Description:

List all users

#### Example:

    Get-GLUsersUsers

### [Install-GLSystemContentPacksContentPack](Install-GLSystemContentPacksContentPack.md)

#### Description:

Install a revision of a content pack

#### Example:

    Install-GLSystemContentPacksContentPack -Contentpackid <String> -Revision <Int> -InstallationRequest <String>

### [Measure-GLIndexerFailuresCount](Measure-GLIndexerFailuresCount.md)

#### Description:

Total count of failed index operations since the given date.

#### Example:

    Measure-GLIndexerFailuresCount -Since <String>

### [New-GLDashboards](New-GLDashboards.md)

#### Description:

Create a dashboard

#### Example:

    New-GLDashboards -Body <PSCustomObject>

### [New-GLExtractors](New-GLExtractors.md)

#### Description:

Add an extractor to an input

#### Example:

    New-GLExtractors -Inputid <String> -Body <PSCustomObject>

### [New-GLPipelinesPipelinesFromParser](New-GLPipelinesPipelinesFromParser.md)

#### Description:

Create a processing pipeline from source

#### Example:

    New-GLPipelinesPipelinesFromParser -Pipeline <String>

### [New-GLPipelinesRulesFromParser](New-GLPipelinesRulesFromParser.md)

#### Description:

Create a processing rule from source

#### Example:

    New-GLPipelinesRulesFromParser -Rule <String>

### [New-GLPluginsCollectorConfigurationConfiguration](New-GLPluginsCollectorConfigurationConfiguration.md)

#### Description:

Create new collector configuration

#### Example:

    New-GLPluginsCollectorConfigurationConfiguration -Createdefaults <String> -Body <PSCustomObject>

### [New-GLPluginsCollectorConfigurationInput](New-GLPluginsCollectorConfigurationInput.md)

#### Description:

Create a configuration input

#### Example:

    New-GLPluginsCollectorConfigurationInput -Id <String> -Body <PSCustomObject>

### [New-GLPluginsCollectorConfigurationOutput](New-GLPluginsCollectorConfigurationOutput.md)

#### Description:

Create a configuration output

#### Example:

    New-GLPluginsCollectorConfigurationOutput -Id <String> -Body <PSCustomObject>

### [New-GLPluginsCollectorConfigurationSnippet](New-GLPluginsCollectorConfigurationSnippet.md)

#### Description:

Create a configuration snippet

#### Example:

    New-GLPluginsCollectorConfigurationSnippet -Id <String> -Body <PSCustomObject>

### [New-GLRoles](New-GLRoles.md)

#### Description:

Create a new role

#### Example:

    New-GLRoles -Body <PSCustomObject>

### [New-GLSearchDecorators](New-GLSearchDecorators.md)

#### Description:

Creates a message decoration configuration

#### Example:

    New-GLSearchDecorators -Body <PSCustomObject>

### [New-GLSearchSaved](New-GLSearchSaved.md)

#### Description:

Create a new saved search

#### Example:

    New-GLSearchSaved -Body <PSCustomObject>

### [New-GLSidecarCollectorsCollector](New-GLSidecarCollectorsCollector.md)

#### Description:

Create a new collector

#### Example:

    New-GLSidecarCollectorsCollector -Body <PSCustomObject>

### [New-GLSidecarConfigurationsConfiguration](New-GLSidecarConfigurationsConfiguration.md)

#### Description:

Create new configuration

#### Example:

    New-GLSidecarConfigurationsConfiguration -Body <PSCustomObject>

### [New-GLSidecarConfigurationVariablesConfigurationVariable](New-GLSidecarConfigurationVariablesConfigurationVariable.md)

#### Description:

Create new configuration variable

#### Example:

    New-GLSidecarConfigurationVariablesConfigurationVariable -Body <PSCustomObject>

### [New-GLStaticFields](New-GLStaticFields.md)

#### Description:

Add a static field to an input

#### Example:

    New-GLStaticFields -Inputid <String> -Body <PSCustomObject>

### [New-GLStreamAlarmCallbacks](New-GLStreamAlarmCallbacks.md)

#### Description:

Create an alarm callback

#### Example:

    New-GLStreamAlarmCallbacks -Streamid <String> -Body <PSCustomObject>

### [New-GLStreamAlertConditions](New-GLStreamAlertConditions.md)

#### Description:

Create an alert condition

#### Example:

    New-GLStreamAlertConditions -Streamid <String> -Body <PSCustomObject>

### [New-GLStreamAlertConditionsTest](New-GLStreamAlertConditionsTest.md)

#### Description:

Test new alert condition

#### Example:

    New-GLStreamAlertConditionsTest -Streamid <String> -AlertConditionParameters <String>

### [New-GLStreamRules](New-GLStreamRules.md)

#### Description:

Create a stream rule

#### Example:

    New-GLStreamRules -Streamid <String> -Body <PSCustomObject>

### [New-GLStreams](New-GLStreams.md)

#### Description:

Create a stream

#### Example:

    New-GLStreams -Body <PSCustomObject>

### [New-GLSystemAuthentication](New-GLSystemAuthentication.md)

#### Description:

Update authentication providers configuration

#### Example:

    New-GLSystemAuthentication -Config <String>

### [New-GLSystemContentPacksContentPack](New-GLSystemContentPacksContentPack.md)

#### Description:

Upload a content pack

#### Example:

    New-GLSystemContentPacksContentPack -RequestBody <String>

### [New-GLSystemDebugEventsGenerateClusterDebugEvent](New-GLSystemDebugEventsGenerateClusterDebugEvent.md)

#### Description:

Create and send a cluster debug event.

#### Example:

    New-GLSystemDebugEventsGenerateClusterDebugEvent -Text <String>

### [New-GLSystemDebugEventsGenerateDebugEvent](New-GLSystemDebugEventsGenerateDebugEvent.md)

#### Description:

Create and send a local debug event.

#### Example:

    New-GLSystemDebugEventsGenerateDebugEvent -Text <String>

### [New-GLSystemDeflectorDeprecatedCycle](New-GLSystemDeflectorDeprecatedCycle.md)

#### Description:

Cycle deflector to new/next index

#### Example:

    New-GLSystemDeflectorDeprecatedCycle

### [New-GLSystemGrokPattern](New-GLSystemGrokPattern.md)

#### Description:

Add a new named pattern

#### Example:

    New-GLSystemGrokPattern -Pattern <String>

### [New-GLSystemInputs](New-GLSystemInputs.md)

#### Description:

Launch input on this node

#### Example:

    New-GLSystemInputs -Body <PSCustomObject>

### [New-GLSystemJobsTrigger](New-GLSystemJobsTrigger.md)

#### Description:

Trigger new job

#### Example:

    New-GLSystemJobsTrigger -Body <PSCustomObject>

### [New-GLSystemLookupAdapter](New-GLSystemLookupAdapter.md)

#### Description:

Create a new data adapter

#### Example:

    New-GLSystemLookupAdapter -Body <String>

### [New-GLSystemLookupCache](New-GLSystemLookupCache.md)

#### Description:

Create a new cache

#### Example:

    New-GLSystemLookupCache -Body <String>

### [New-GLSystemLookupTable](New-GLSystemLookupTable.md)

#### Description:

Create a new lookup table

#### Example:

    New-GLSystemLookupTable -Body <String>

### [New-GLSystemOutputs](New-GLSystemOutputs.md)

#### Description:

Create an output

#### Example:

    New-GLSystemOutputs -Body <PSCustomObject>

### [New-GLSystemSessionsSession](New-GLSystemSessionsSession.md)

#### Description:

Create a new session

#### Example:

    New-GLSystemSessionsSession -LoginRequest <String>

### [New-GLUsers](New-GLUsers.md)

#### Description:

Create a new user account.

#### Example:

    New-GLUsers -Body <PSCustomObject>

### [New-GLUsersGenerateToken](New-GLUsersGenerateToken.md)

#### Description:

Generates a new access token for a user

#### Example:

    New-GLUsersGenerateToken -Username <String> -Name <String> -Body <String>

### [Open-GLIndexerIndicesClosed](Open-GLIndexerIndicesClosed.md)

#### Description:

Get a list of closed indices that can be reopened.

#### Example:

    Open-GLIndexerIndicesClosed

### [Open-GLIndexerIndicesIndexClosed](Open-GLIndexerIndicesIndexClosed.md)

#### Description:

Get a list of closed indices that can be reopened.

#### Example:

    Open-GLIndexerIndicesIndexClosed -Indexsetid <String>

### [Open-GLIndexerIndicesIndexReed](Open-GLIndexerIndicesIndexReed.md)

#### Description:

Get a list of reopened indices, which will not be cleaned by retention cleaning

#### Example:

    Open-GLIndexerIndicesIndexReed -Indexsetid <String>

### [Open-GLIndexerIndicesRe](Open-GLIndexerIndicesRe.md)

#### Description:

Reopen a closed index. This will also trigger an index ranges rebuild job.

#### Example:

    Open-GLIndexerIndicesRe -Index <String>

### [Open-GLIndexerIndicesReed](Open-GLIndexerIndicesReed.md)

#### Description:

Get a list of reopened indices, which will not be cleaned by retention cleaning

#### Example:

    Open-GLIndexerIndicesReed

### [Parse-GLMessages](Parse-GLMessages.md)

#### Description:

Parse a raw message

#### Example:

    Parse-GLMessages -Body <PSCustomObject>

### [Parse-GLPipelinesPipelines](Parse-GLPipelinesPipelines.md)

#### Description:

Parse a processing pipeline without saving it

#### Example:

    Parse-GLPipelinesPipelines -Pipeline <String>

### [Parse-GLPipelinesRules](Parse-GLPipelinesRules.md)

#### Description:

Parse a processing rule without saving it

#### Example:

    Parse-GLPipelinesRules -Rule <String>

### [Pause-GLClusterProcessing](Pause-GLClusterProcessing.md)

#### Description:

Pause message processing on node

#### Example:

    Pause-GLClusterProcessing -Nodeid <String>

### [Pause-GLStreams](Pause-GLStreams.md)

#### Description:

Pause a stream

#### Example:

    Pause-GLStreams -Streamid <String>

### [Remove-GLDashboards](Remove-GLDashboards.md)

#### Description:

Delete a dashboard and all its widgets

#### Example:

    Remove-GLDashboards -Dashboardid <String>

### [Remove-GLDashboardsWidgets](Remove-GLDashboardsWidgets.md)

#### Description:

Delete a widget

#### Example:

    Remove-GLDashboardsWidgets -Dashboardid <String> -Widgetid <String>

### [Remove-GLExtractorsTerminate](Remove-GLExtractorsTerminate.md)

#### Description:

Delete an extractor

#### Example:

    Remove-GLExtractorsTerminate -Inputid <String> -Extractorid <String>

### [Remove-GLIndexerIndices](Remove-GLIndexerIndices.md)

#### Description:

Delete an index. This will also trigger an index ranges rebuild job.

#### Example:

    Remove-GLIndexerIndices -Index <String>

### [Remove-GLPipelinesPipelines](Remove-GLPipelinesPipelines.md)

#### Description:

Delete a processing pipeline

#### Example:

    Remove-GLPipelinesPipelines -Id <String>

### [Remove-GLPipelinesRules](Remove-GLPipelinesRules.md)

#### Description:

Delete a processing rule

#### Example:

    Remove-GLPipelinesRules -Id <String>

### [Remove-GLPluginsCollectorConfigurationConfiguration](Remove-GLPluginsCollectorConfigurationConfiguration.md)

#### Description:

Delete a collector configuration

#### Example:

    Remove-GLPluginsCollectorConfigurationConfiguration -Id <String>

### [Remove-GLPluginsCollectorConfigurationInput](Remove-GLPluginsCollectorConfigurationInput.md)

#### Description:

Delete input form configuration

#### Example:

    Remove-GLPluginsCollectorConfigurationInput -Id <String>

### [Remove-GLPluginsCollectorConfigurationOutput](Remove-GLPluginsCollectorConfigurationOutput.md)

#### Description:

Delete output from configuration

#### Example:

    Remove-GLPluginsCollectorConfigurationOutput -Id <String>

### [Remove-GLPluginsCollectorConfigurationSnippet](Remove-GLPluginsCollectorConfigurationSnippet.md)

#### Description:

Delete snippet from configuration

#### Example:

    Remove-GLPluginsCollectorConfigurationSnippet -Id <String>

### [Remove-GLRoles](Remove-GLRoles.md)

#### Description:

Remove the named role and dissociate any users from it

#### Example:

    Remove-GLRoles -Rolename <String>

### [Remove-GLRolesMember](Remove-GLRolesMember.md)

#### Description:

Remove a user from a role

#### Example:

    Remove-GLRolesMember -Rolename <String> -Username <String>

### [Remove-GLSearchDecorators](Remove-GLSearchDecorators.md)

#### Description:

Create a decorator

#### Example:

    Remove-GLSearchDecorators -DecoratorId <String>

### [Remove-GLSearchSaved](Remove-GLSearchSaved.md)

#### Description:

Delete a saved search

#### Example:

    Remove-GLSearchSaved -Searchid <String>

### [Remove-GLSidecarCollectorsCollector](Remove-GLSidecarCollectorsCollector.md)

#### Description:

Delete a collector

#### Example:

    Remove-GLSidecarCollectorsCollector -Id <String>

### [Remove-GLSidecarConfigurationsConfiguration](Remove-GLSidecarConfigurationsConfiguration.md)

#### Description:

Delete a configuration

#### Example:

    Remove-GLSidecarConfigurationsConfiguration -Id <String>

### [Remove-GLSidecarConfigurationVariablesConfigurationVariable](Remove-GLSidecarConfigurationVariablesConfigurationVariable.md)

#### Description:

Delete a configuration variable

#### Example:

    Remove-GLSidecarConfigurationVariablesConfigurationVariable -Id <String>

### [Remove-GLStaticFields](Remove-GLStaticFields.md)

#### Description:

Remove static field of an input

#### Example:

    Remove-GLStaticFields -Key <String> -Inputid <String>

### [Remove-GLStreamAlarmCallbacks](Remove-GLStreamAlarmCallbacks.md)

#### Description:

Delete an alarm callback

#### Example:

    Remove-GLStreamAlarmCallbacks -Streamid <String> -Alarmcallbackid <String>

### [Remove-GLStreamAlertConditions](Remove-GLStreamAlertConditions.md)

#### Description:

Delete an alert condition

#### Example:

    Remove-GLStreamAlertConditions -Streamid <String> -Conditionid <String>

### [Remove-GLStreamAlertsReceiver](Remove-GLStreamAlertsReceiver.md)

#### Description:

Remove an alert receiver

#### Example:

    Remove-GLStreamAlertsReceiver -Streamid <String> -Entity <String> -Type <String>

### [Remove-GLStreamOutputs](Remove-GLStreamOutputs.md)

#### Description:

Delete output of a stream

#### Example:

    Remove-GLStreamOutputs -Streamid <String> -Outputid <String>

### [Remove-GLStreamRules](Remove-GLStreamRules.md)

#### Description:

Delete a stream rule

#### Example:

    Remove-GLStreamRules -Streamid <String> -Streamruleid <String>

### [Remove-GLStreams](Remove-GLStreams.md)

#### Description:

Delete a stream

#### Example:

    Remove-GLStreams -Streamid <String>

### [Remove-GLSystemClusterConfig](Remove-GLSystemClusterConfig.md)

#### Description:

Delete configuration settings from database

#### Example:

    Remove-GLSystemClusterConfig -Configclass <String>

### [Remove-GLSystemContentPacksContentPack](Remove-GLSystemContentPacksContentPack.md)

#### Description:

Delete one revision of a content pack

#### Example:

    Remove-GLSystemContentPacksContentPack -Contentpackid <String> -Revision <Int>

### [Remove-GLSystemContentPacksContentPackAll](Remove-GLSystemContentPacksContentPackAll.md)

#### Description:

Delete all revisions of a content pack

#### Example:

    Remove-GLSystemContentPacksContentPackAll -Contentpackid <String>

### [Remove-GLSystemContentPacksContentPackInstallationById](Remove-GLSystemContentPacksContentPackInstallationById.md)

#### Description:

Uninstall a content pack installation

#### Example:

    Remove-GLSystemContentPacksContentPackInstallationById -Contentpackid <String> -Installationid <String>

### [Remove-GLSystemGrokPattern](Remove-GLSystemGrokPattern.md)

#### Description:

Remove an existing pattern by id

#### Example:

    Remove-GLSystemGrokPattern -Patternid <String>

### [Remove-GLSystemIndexSets](Remove-GLSystemIndexSets.md)

#### Description:

Delete index set

#### Example:

    Remove-GLSystemIndexSets -Id <String> -Delete_Indices <Bool>

### [Remove-GLSystemLDAPLdaptings](Remove-GLSystemLDAPLdaptings.md)

#### Description:

Remove the LDAP configuration

#### Example:

    Remove-GLSystemLDAPLdaptings

### [Remove-GLSystemLookupAdapter](Remove-GLSystemLookupAdapter.md)

#### Description:

Delete the given data adapter

#### Example:

    Remove-GLSystemLookupAdapter -Idorname <String>

### [Remove-GLSystemLookupCache](Remove-GLSystemLookupCache.md)

#### Description:

Delete the given cache

#### Example:

    Remove-GLSystemLookupCache -Idorname <String>

### [Remove-GLSystemLookupTable](Remove-GLSystemLookupTable.md)

#### Description:

Delete the lookup table

#### Example:

    Remove-GLSystemLookupTable -Idorname <String>

### [Remove-GLSystemNotificationsNotification](Remove-GLSystemNotificationsNotification.md)

#### Description:

Delete a notification

#### Example:

    Remove-GLSystemNotificationsNotification -Notificationtype <String>

### [Remove-GLSystemOutputs](Remove-GLSystemOutputs.md)

#### Description:

Delete output

#### Example:

    Remove-GLSystemOutputs -Outputid <String>

### [Remove-GLUsersPermissions](Remove-GLUsersPermissions.md)

#### Description:

Revoke all permissions for a user without deleting the account.

#### Example:

    Remove-GLUsersPermissions -Username <String>

### [Remove-GLUsersUser](Remove-GLUsersUser.md)

#### Description:

Removes a user account.

#### Example:

    Remove-GLUsersUser -Username <String>

### [Resolve-GLSystemCatalogEntities](Resolve-GLSystemCatalogEntities.md)

#### Description:

Resolve dependencies of entities and return their configuration

#### Example:

    Resolve-GLSystemCatalogEntities -Body <PSCustomObject>

### [Resolve-GLSystemLookupPerformAdapterLookup](Resolve-GLSystemLookupPerformAdapterLookup.md)

#### Description:

Query a lookup table

#### Example:

    Resolve-GLSystemLookupPerformAdapterLookup -Name <String> -Key <String>

### [Resolve-GLSystemLookupPerformLookup](Resolve-GLSystemLookupPerformLookup.md)

#### Description:

Query a lookup table

#### Example:

    Resolve-GLSystemLookupPerformLookup -Name <String> -Key <String>

### [Resolve-GLSystemLookupPerformPurge](Resolve-GLSystemLookupPerformPurge.md)

#### Description:

Purge lookup table cache

#### Example:

    Resolve-GLSystemLookupPerformPurge -Idorname <String> -Key <String>

### [Resume-GLClusterProcessing](Resume-GLClusterProcessing.md)

#### Description:

Resume message processing on node

#### Example:

    Resume-GLClusterProcessing -Nodeid <String>

### [Resume-GLStreams](Resume-GLStreams.md)

#### Description:

Resume a stream

#### Example:

    Resume-GLStreams -Streamid <String>

### [Revoke-GLUsersToken](Revoke-GLUsersToken.md)

#### Description:

Removes a token for a user

#### Example:

    Revoke-GLUsersToken -Username <String> -Token <String>

### [Send-GLAlarmCallbacksTest](Send-GLAlarmCallbacksTest.md)

#### Description:

Send a test alert for a given alarm callback

#### Example:

    Send-GLAlarmCallbacksTest -Alarmcallbackid <String>

### [Send-GLHelloWorldRedirectToWebConsole](Send-GLHelloWorldRedirectToWebConsole.md)

#### Description:

Redirecting to web console if it runs on same port.

#### Example:

    Send-GLHelloWorldRedirectToWebConsole

### [Send-GLStreamAlertsDummyAlert](Send-GLStreamAlertsDummyAlert.md)

#### Description:

Send a test mail for a given stream

#### Example:

    Send-GLStreamAlertsDummyAlert -Streamid <String>

### [Set-GLClusterInputStateStart](Set-GLClusterInputStateStart.md)

#### Description:

Start or restart specified input in all nodes

#### Example:

    Set-GLClusterInputStateStart -Inputid <String>

### [Set-GLClusterInputStateStop](Set-GLClusterInputStateStop.md)

#### Description:

Stop specified input in all nodes

#### Example:

    Set-GLClusterInputStateStop -Inputid <String>

### [Set-GLClusterLoadBalancersOverride](Set-GLClusterLoadBalancersOverride.md)

#### Description:

Override load balancer status of this graylog-server node. Next lifecycle change will override it again to its default. Set to ALIVE, DEAD, or THROTTLED.

#### Example:

    Set-GLClusterLoadBalancersOverride -Nodeid <String> -Status <String>

### [Set-GLClusterSystemLoggersSubsystemLoggerLevel](Set-GLClusterSystemLoggersSubsystemLoggerLevel.md)

#### Description:

Set the loglevel of a whole subsystem

#### Example:

    Set-GLClusterSystemLoggersSubsystemLoggerLevel -Nodeid <String> -Subsystem <String> -Level <String>

### [Set-GLDashboardsPositions](Set-GLDashboardsPositions.md)

#### Description:

Update/set the positions of dashboard widgets.

#### Example:

    Set-GLDashboardsPositions -Dashboardid <String> -Body <PSCustomObject>

### [Set-GLIndexerIndicesTemplatesSync](Set-GLIndexerIndicesTemplatesSync.md)

#### Description:

Updates the index template for the given index set in Elasticsearch

#### Example:

    Set-GLIndexerIndicesTemplatesSync -Indexsetid <String>

### [Set-GLIndexerIndicesTemplatesSyncAll](Set-GLIndexerIndicesTemplatesSyncAll.md)

#### Description:

Updates the index templates for all index sets in Elasticsearch

#### Example:

    Set-GLIndexerIndicesTemplatesSyncAll

### [Set-GLPluginsSystemCollectorsAction](Set-GLPluginsSystemCollectorsAction.md)

#### Description:

Set a collector action

#### Example:

    Set-GLPluginsSystemCollectorsAction -Collectorid <String> -Body <PSCustomObject>

### [Set-GLPluginsSystemCollectorsRegister](Set-GLPluginsSystemCollectorsRegister.md)

#### Description:

Create/update a collector registration

#### Example:

    Set-GLPluginsSystemCollectorsRegister -Collectorid <String> -Body <PSCustomObject>

### [Set-GLPluginsSystemCollectorsUpload](Set-GLPluginsSystemCollectorsUpload.md)

#### Description:

Pass back rendered collector configuratin

#### Example:

    Set-GLPluginsSystemCollectorsUpload -Collectorid <String> -Body <PSCustomObject>

### [Set-GLRolesAddMember](Set-GLRolesAddMember.md)

#### Description:

Add a user to a role

#### Example:

    Set-GLRolesAddMember -Rolename <String> -Username <String> -Body <String>

### [Set-GLSidecarAdministrationAction](Set-GLSidecarAdministrationAction.md)

#### Description:

Set collector actions in bulk

#### Example:

    Set-GLSidecarAdministrationAction -Body <PSCustomObject>

### [Set-GLSidecarAssignConfiguration](Set-GLSidecarAssignConfiguration.md)

#### Description:

Assign configurations to sidecars

#### Example:

    Set-GLSidecarAssignConfiguration -Body <PSCustomObject>

### [Set-GLSidecarCollectorActionsAction](Set-GLSidecarCollectorActionsAction.md)

#### Description:

Set a collector action

#### Example:

    Set-GLSidecarCollectorActionsAction -Sidecarid <String> -Body <PSCustomObject>

### [Set-GLSidecarRegister](Set-GLSidecarRegister.md)

#### Description:

Create/update a Sidecar registration

#### Example:

    Set-GLSidecarRegister -Sidecarid <String> -Body <PSCustomObject>

### [Set-GLSystemDeflectorCycle](Set-GLSystemDeflectorCycle.md)

#### Description:

Cycle deflector to new/next index in index set

#### Example:

    Set-GLSystemDeflectorCycle -Indexsetid <String>

### [Set-GLSystemIndexRangesRebuildIndex](Set-GLSystemIndexRangesRebuildIndex.md)

#### Description:

Rebuild/sync index range information for the given index set.

#### Example:

    Set-GLSystemIndexRangesRebuildIndex -Indexsetid <String>

### [Set-GLSystemIndexSetsDefault](Set-GLSystemIndexSetsDefault.md)

#### Description:

Set default index set

#### Example:

    Set-GLSystemIndexSetsDefault -Id <String>

### [Set-GLSystemIndexSetsSave](Set-GLSystemIndexSetsSave.md)

#### Description:

Create index set

#### Example:

    Set-GLSystemIndexSetsSave -IndexSetConfiguration <String>

### [Set-GLSystemInputStatesStart](Set-GLSystemInputStatesStart.md)

#### Description:

(Re-)Start specified input on this node

#### Example:

    Set-GLSystemInputStatesStart -Inputid <String>

### [Set-GLSystemInputStatesStop](Set-GLSystemInputStatesStop.md)

#### Description:

Stop specified input on this node

#### Example:

    Set-GLSystemInputStatesStop -Inputid <String>

### [Set-GLSystemLoadBalancersOverride](Set-GLSystemLoadBalancersOverride.md)

#### Description:

Override load balancer status of this Graylog server node. Next lifecycle change will override it again to its default. Set to ALIVE, DEAD, or THROTTLED.

#### Example:

    Set-GLSystemLoadBalancersOverride -Status <String>

### [Set-GLSystemLoggersSingleLoggerLevel](Set-GLSystemLoggersSingleLoggerLevel.md)

#### Description:

Set the loglevel of a single logger

#### Example:

    Set-GLSystemLoggersSingleLoggerLevel -Loggername <String> -Level <String>

### [Set-GLSystemLoggersSubsystemLoggerLevel](Set-GLSystemLoggersSubsystemLoggerLevel.md)

#### Description:

Set the loglevel of a whole subsystem

#### Example:

    Set-GLSystemLoggersSubsystemLoggerLevel -Subsystem <String> -Level <String>

### [Set-GLSystemProcessingPauseProcessing](Set-GLSystemProcessingPauseProcessing.md)

#### Description:

Pauses message processing

#### Example:

    Set-GLSystemProcessingPauseProcessing

### [Set-GLSystemProcessingResumeProcessing](Set-GLSystemProcessingResumeProcessing.md)

#### Description:

Resume message processing

#### Example:

    Set-GLSystemProcessingResumeProcessing

### [Set-GLUsersChangePassword](Set-GLUsersChangePassword.md)

#### Description:

Update the password for a user.

#### Example:

    Set-GLUsersChangePassword -Username <String> -Body <PSCustomObject>

### [Set-GLUsersChangeUser](Set-GLUsersChangeUser.md)

#### Description:

Modify user details.

#### Example:

    Set-GLUsersChangeUser -Username <String> -Body <PSCustomObject>

### [Set-GLUsersEditPermissions](Set-GLUsersEditPermissions.md)

#### Description:

Update a user's permission set.

#### Example:

    Set-GLUsersEditPermissions -Username <String> -Body <PSCustomObject>

### [Set-GLUsersSavePreferences](Set-GLUsersSavePreferences.md)

#### Description:

Update a user's preferences set.

#### Example:

    Set-GLUsersSavePreferences -Username <String> -Body <PSCustomObject>

### [Simulate-GLPipelinesSimulator](Simulate-GLPipelinesSimulator.md)

#### Description:

Simulate the execution of the pipeline message processor

#### Example:

    Simulate-GLPipelinesSimulator -Simulation <String>

### [Start-GLClusterDeflectorCycle](Start-GLClusterDeflectorCycle.md)

#### Description:

Finds master node and triggers deflector cycle

#### Example:

    Start-GLClusterDeflectorCycle

### [Start-GLClusterDeflectorCycleAll](Start-GLClusterDeflectorCycleAll.md)

#### Description:

Finds master node and triggers deflector cycle

#### Example:

    Start-GLClusterDeflectorCycle -Indexsetid <String>

### [Start-GLStreamAlertsCheckConditions](Start-GLStreamAlertsCheckConditions.md)

#### Description:

Check for triggered alert conditions of this streams. Results cached for 30 seconds.

#### Example:

    Start-GLStreamAlertsCheckConditions -Streamid <String>

### [Stop-GLClusterShutdownShutdown](Stop-GLClusterShutdownShutdown.md)

#### Description:

Shutdown node gracefully.

#### Example:

    Stop-GLClusterShutdownShutdown -Nodeid <String>

### [Stop-GLSystemInputsTerminate](Stop-GLSystemInputsTerminate.md)

#### Description:

Terminate input on this node

#### Example:

    Stop-GLSystemInputsTerminate -Inputid <String>

### [Stop-GLSystemSessionsTerminateSession](Stop-GLSystemSessionsTerminateSession.md)

#### Description:

Terminate an existing session

#### Example:

    Stop-GLSystemSessionsTerminateSession -Sessionid <String>

### [Stop-GLSystemShutdownShutdown](Stop-GLSystemShutdownShutdown.md)

#### Description:

Shutdown this node gracefully.

#### Example:

    Stop-GLSystemShutdownShutdown

### [Test-GLHelloWorldHelloWorld](Test-GLHelloWorldHelloWorld.md)

#### Description:

A few details about the Graylog node.

#### Example:

    Test-GLHelloWorldHelloWorld

### [Test-GLSidecarCollectorsValidateCollector](Test-GLSidecarCollectorsValidateCollector.md)

#### Description:

Validates collector parameters

#### Example:

    Test-GLSidecarCollectorsValidateCollector -Body <String>

### [Test-GLSidecarConfigurationsValidateConfiguration](Test-GLSidecarConfigurationsValidateConfiguration.md)

#### Description:

Validates configuration parameters

#### Example:

    Test-GLSidecarConfigurationsValidateConfiguration -Body <String>

### [Test-GLSidecarConfigurationVariablesValidateConfigurationVariable](Test-GLSidecarConfigurationVariablesValidateConfigurationVariable.md)

#### Description:

Validate a configuration variable

#### Example:

    Test-GLSidecarConfigurationVariablesValidateConfigurationVariable -Body <PSCustomObject>

### [Test-GLStreamAlertConditionsExisting](Test-GLStreamAlertConditionsExisting.md)

#### Description:

Test existing alert condition

#### Example:

    Test-GLStreamAlertConditionsExisting -Streamid <String> -Conditionid <String>

### [Test-GLStreamsMatch](Test-GLStreamsMatch.md)

#### Description:

Test matching of a stream against a supplied message

#### Example:

    Test-GLStreamsMatch -Streamid <String> -Body <PSCustomObject>

### [Test-GLSystemGrokPattern](Test-GLSystemGrokPattern.md)

#### Description:

Test pattern with sample data

#### Example:

    Test-GLSystemGrokPattern -Pattern <String>

### [Test-GLSystemLDAPLdapConfiguration](Test-GLSystemLDAPLdapConfiguration.md)

#### Description:

Test LDAP Configuration

#### Example:

    Test-GLSystemLDAPLdapConfiguration -ConfigurationToTest <String>

### [Test-GLSystemLookupValidateAdapter](Test-GLSystemLookupValidateAdapter.md)

#### Description:

Validate the data adapter config

#### Example:

    Test-GLSystemLookupValidateAdapter -Body <String>

### [Test-GLSystemLookupValidateCache](Test-GLSystemLookupValidateCache.md)

#### Description:

Validate the cache config

#### Example:

    Test-GLSystemLookupValidateCache -Body <String>

### [Test-GLSystemLookupValidateTable](Test-GLSystemLookupValidateTable.md)

#### Description:

Validate the lookup table config

#### Example:

    Test-GLSystemLookupValidateTable -Body <String>

### [Test-GLSystemSessionsValidateSession](Test-GLSystemSessionsValidateSession.md)

#### Description:

Validate an existing session

#### Example:

    Test-GLSystemSessionsValidateSession

### [Update-GLDashboards](Update-GLDashboards.md)

#### Description:

Update the settings of a dashboard.

#### Example:

    Update-GLDashboards -Dashboardid <String> -Body <PSCustomObject>

### [Update-GLDashboardsWidgetsCacheTime](Update-GLDashboardsWidgetsCacheTime.md)

#### Description:

Update cache time of a widget

#### Example:

    Update-GLDashboardsWidgetsCacheTime -Dashboardid <String> -Widgetid <String> -Body <PSCustomObject>

### [Update-GLDashboardsWidgetsDescription](Update-GLDashboardsWidgetsDescription.md)

#### Description:

Update description of a widget

#### Example:

    Update-GLDashboardsWidgetsDescription -Dashboardid <String> -Widgetid <String> -Body <PSCustomObject>

### [Update-GLDashboardsWidgetsWid](Update-GLDashboardsWidgetsWid.md)

#### Description:

Update a widget

#### Example:

    Update-GLDashboardsWidgetsWid -Dashboardid <String> -Widgetid <String> -Body <PSCustomObject>

### [Update-GLExtractors](Update-GLExtractors.md)

#### Description:

Update an extractor

#### Example:

    Update-GLExtractors -Inputid <String> -Extractorid <String> -Body <PSCustomObject>

### [Update-GLPipelinesPipelines](Update-GLPipelinesPipelines.md)

#### Description:

Modify a processing pipeline

#### Example:

    Update-GLPipelinesPipelines -Id <String> -Pipeline <String>

### [Update-GLPipelinesRules](Update-GLPipelinesRules.md)

#### Description:

Modify a processing rule

#### Example:

    Update-GLPipelinesRules -Id <String> -Rule <String>

### [Update-GLPluginsCollectorConfigurationConfigurationName](Update-GLPluginsCollectorConfigurationConfigurationName.md)

#### Description:

Updates a collector configuration name

#### Example:

    Update-GLPluginsCollectorConfigurationConfigurationName -Id <String> -Body <PSCustomObject>

### [Update-GLPluginsCollectorConfigurationInput](Update-GLPluginsCollectorConfigurationInput.md)

#### Description:

Update a configuration input

#### Example:

    Update-GLPluginsCollectorConfigurationInput -Id <String> -Input_Id <String> -Body <PSCustomObject>

### [Update-GLPluginsCollectorConfigurationOutput](Update-GLPluginsCollectorConfigurationOutput.md)

#### Description:

Update a configuration output

#### Example:

    Update-GLPluginsCollectorConfigurationOutput -Id <String> -Output_Id <String> -Body <PSCustomObject>

### [Update-GLPluginsCollectorConfigurationSnippet](Update-GLPluginsCollectorConfigurationSnippet.md)

#### Description:

Update a configuration snippet

#### Example:

    Update-GLPluginsCollectorConfigurationSnippet -Id <String> -Snippet_Id <String> -Body <PSCustomObject>

### [Update-GLRoles](Update-GLRoles.md)

#### Description:

Update an existing role

#### Example:

    Update-GLRoles -Rolename <String> -Body <PSCustomObject>

### [Update-GLSearchDecorators](Update-GLSearchDecorators.md)

#### Description:

Update a decorator

#### Example:

    Update-GLSearchDecorators -DecoratorId <String> -Body <PSCustomObject>

### [Update-GLSearchSaved](Update-GLSearchSaved.md)

#### Description:

Update a saved search

#### Example:

    Update-GLSearchSaved -Searchid <String> -Body <PSCustomObject>

### [Update-GLSidecarCollectorsCollector](Update-GLSidecarCollectorsCollector.md)

#### Description:

Update a collector

#### Example:

    Update-GLSidecarCollectorsCollector -Id <String> -Body <PSCustomObject>

### [Update-GLSidecarConfigurationsConfiguration](Update-GLSidecarConfigurationsConfiguration.md)

#### Description:

Update a configuration

#### Example:

    Update-GLSidecarConfigurationsConfiguration -Id <String> -Body <PSCustomObject>

### [Update-GLSidecarConfigurationVariablesConfigurationVariable](Update-GLSidecarConfigurationVariablesConfigurationVariable.md)

#### Description:

Update a configuration variable

#### Example:

    Update-GLSidecarConfigurationVariablesConfigurationVariable -Id <String> -Body <PSCustomObject>

### [Update-GLStreamAlarmCallbacks](Update-GLStreamAlarmCallbacks.md)

#### Description:

Update an alarm callback

#### Example:

    Update-GLStreamAlarmCallbacks -Streamid <String> -Alarmcallbackid <String> -Body <PSCustomObject>

### [Update-GLStreamAlertConditions](Update-GLStreamAlertConditions.md)

#### Description:

Modify an alert condition

#### Example:

    Update-GLStreamAlertConditions -Streamid <String> -Conditionid <String> -Body <PSCustomObject>

### [Update-GLStreamRules](Update-GLStreamRules.md)

#### Description:

Update a stream rule

#### Example:

    Update-GLStreamRules -Streamid <String> -Streamruleid <String> -Body <PSCustomObject>

### [Update-GLStreams](Update-GLStreams.md)

#### Description:

Update a stream

#### Example:

    Update-GLStreams -Streamid <String> -Body <PSCustomObject>

### [Update-GLSystemClusterConfig](Update-GLSystemClusterConfig.md)

#### Description:

Update configuration in database

#### Example:

    Update-GLSystemClusterConfig -Configclass <String> -Body <String>

### [Update-GLSystemGrokBulkPatterns](Update-GLSystemGrokBulkPatterns.md)

#### Description:

Add a list of new patterns

#### Example:

    Update-GLSystemGrokBulkPatterns -Patterns <String> -Replace <Bool>

### [Update-GLSystemGrokBulkPatternsFromTextFile](Update-GLSystemGrokBulkPatternsFromTextFile.md)

#### Description:

Add a list of new patterns

#### Example:

    Update-GLSystemGrokBulkPatternsFromTextFile -Patterns <String> -Replace <Bool>

### [Update-GLSystemGrokPattern](Update-GLSystemGrokPattern.md)

#### Description:

Update an existing pattern

#### Example:

    Update-GLSystemGrokPattern -Patternid <String> -Pattern <String>

### [Update-GLSystemIndexSets](Update-GLSystemIndexSets.md)

#### Description:

Update index set

#### Example:

    Update-GLSystemIndexSets -Id <String> -IndexSetConfiguration <String>

### [Update-GLSystemInputs](Update-GLSystemInputs.md)

#### Description:

Update input on this node

#### Example:

    Update-GLSystemInputs -Body <PSCustomObject> -Inputid <String>

### [Update-GLSystemLDAPGroupMappingtings](Update-GLSystemLDAPGroupMappingtings.md)

#### Description:

Update the LDAP group to Graylog role mapping

#### Example:

    Update-GLSystemLDAPGroupMappingtings -Body <PSCustomObject>

### [Update-GLSystemLDAPLdaptings](Update-GLSystemLDAPLdaptings.md)

#### Description:

Update the LDAP configuration

#### Example:

    Update-GLSystemLDAPLdaptings -Body <PSCustomObject>

### [Update-GLSystemLookupAdapter](Update-GLSystemLookupAdapter.md)

#### Description:

Update the given data adapter settings

#### Example:

    Update-GLSystemLookupAdapter -Idorname <String> -Body <String>

### [Update-GLSystemLookupCache](Update-GLSystemLookupCache.md)

#### Description:

Update the given cache settings

#### Example:

    Update-GLSystemLookupCache -Idorname <String> -Body <String>

### [Update-GLSystemLookupTable](Update-GLSystemLookupTable.md)

#### Description:

Update the given lookup table

#### Example:

    Update-GLSystemLookupTable -Idorname <String> -Body <String>

### [Update-GLSystemMessageProcessorsConfig](Update-GLSystemMessageProcessorsConfig.md)

#### Description:

Update message processor configuration

#### Example:

    Update-GLSystemMessageProcessorsConfig -Config <String>

### [Update-GLSystemOutputs](Update-GLSystemOutputs.md)

#### Description:

Update output

#### Example:

    Update-GLSystemOutputs -Outputid <String> -Body <PSCustomObject>

### [Convert-GLTokenToCredential](Convert-GLTokenToCredential.md)

#### Description:

Converts graylog token to [PSCredential]

#### Example:

    PS C:\> Convert-GLTokenToCredential -Token $Key

### [Set-GLAPIConfig](Set-GLAPIConfig.md)

#### Description:

Simple function that sets the global variables "`$Global:GLApiUrl" and "`$Global:GLCredential"

#### Example:

    PS C:\> Set-GLApiConfig -ApiUrl "https://graylog.domain.com/api" -Credential $MyCredential
    PS C:\> $TokenCreds = Convert-GLTokenToCredential -Token abcdefghijklmnop123


