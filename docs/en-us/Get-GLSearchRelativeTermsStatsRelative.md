---
external help file: PSGraylog-help.xml
Module Name: PSGraylog
online version:
schema: 2.0.0
---

# Get-GLSearchRelativeTermsStatsRelative

## SYNOPSIS
Ordered field terms of a query computed on another field using a relative timerange.

## SYNTAX

```
Get-GLSearchRelativeTermsStatsRelative [-Key_Field] <String> [-Value_Field] <String> [-Order] <String>
 [-Query] <String> [[-Size] <Int32>] [-Range] <Int32> [[-Filter] <String>] [[-APIUrl] <String>]
 [[-Credential] <PSCredential>] [<CommonParameters>]
```

## DESCRIPTION
Ordered field terms of a query computed on another field using a relative timerange.


For more information about this cmdlet - please search for /search/universal/relative/termsstats in the docs available at http(s)://your-graylog.fqdn/api/api-docs

## EXAMPLES

### EXAMPLE 1
```
-Value_Field <String> -Order <String> -Query <String> -Size <Int> -Range <Int> -Filter <String>
```

## PARAMETERS

### -Key_Field
Message field of to return terms of

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Value_Field
Value field used for computation

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Order
What to order on (Allowed values: TERM, REVERSE_TERM, COUNT, REVERSE_COUNT, TOTAL, REVERSE_TOTAL, MIN, REVERSE_MIN, MAX, REVERSE_MAX, MEAN, REVERSE_MEAN)

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Query
Query (Lucene syntax)

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 4
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Size
Maximum number of terms to return

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Range
Relative timeframe to search in.
See search method description.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 6
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Filter
Filter

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -APIUrl
Base url for the API, normally https://\<grayloghost\>:\<port\>/api

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: $Global:GLApiUrl
Accept pipeline input: False
Accept wildcard characters: False
```

### -Credential
Graylog credentials as username:password or use Convert-GLTokenToCredential for token usage

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: $Global:GLCredential
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Auto generated

## RELATED LINKS
