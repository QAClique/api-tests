#---------------------------------------------------------------------------------------------------
Feature: Globe And Mail - Mutual fund leaders Tests
#---------------------------------------------------------------------------------------------------

#---------------------------------------------------------------------------------------------------
Background:
#---------------------------------------------------------------------------------------------------

  * url "https://globeandmail.pl.barchart.com/module/dataTable.json"

#---------------------------------------------------------------------------------------------------
Scenario: Globe And Mail - Mutual fund leaders (unsorted)
#---------------------------------------------------------------------------------------------------

  * def fundSchema =
    """
    {
      "symbol": "#string",
      "symbolName": "#string",
      "lastPrice": "#string",
      "priceChange": "#string",
      "percentChange": "#string",
      "managedAssets": "#string",
      "tradeTime": "#regex ^[0-9]{2}/[0-9]{2}/[0-9]{2}$",
      "symbolType": "#number",
      "exchange": "CADFUNDS",
      "symbolCurrency": "#regex ^(CAD|USD)$",
      "raw": {
        "symbol": "#string",
        "symbolName": "#string",
        "lastPrice": "#number",
        "priceChange": "#number",
        "percentChange": "#number",
        "managedAssets": "#number",
        "tradeTime": "#number",
        "symbolType": "#number",
        "exchange": "CADFUNDS",
        "symbolCurrency": "#regex ^(CAD|USD)$"
      }
    }
    """
  * def fundListSchema =
    """
    {
      "data": "#[] fundSchema",
      "meta": {
        "field": {
          "name": {
            "symbol": "Symbol",
            "symbolName": "Name",
            "lastPrice": "Last",
            "priceChange": "Change",
            "percentChange": "% Change",
            "managedAssets": "AUM",
            "tradeTime": "Time",
            "quickLink": "Quick Link",
            "symbolType": "Type",
            "exchange": "Exchange",
            "symbolCurrency": "Symbol Currency",
            "noteText": "Note Text"
          },
          "type": {
            "symbol": "string",
            "symbolName": "string",
            "lastPrice": "price",
            "priceChange": "priceChange",
            "percentChange": "percentChange",
            "managedAssets": "integer",
            "tradeTime": "time",
            "quickLink": null,
            "symbolType": "string",
            "exchange": "string",
            "symbolCurrency": "string",
            "noteText": null
          },
          "describedBy": {
            "managedAssets": "Assets Under Management"
          },
          "display": {
            "symbol": true,
            "symbolName": true,
            "lastPrice": true,
            "priceChange": true,
            "percentChange": true,
            "managedAssets": true,
            "tradeTime": true,
            "quickLink": true,
            "symbolType": false,
            "exchange": false,
            "symbolCurrency": false,
            "noteText": false
          }
        }
      },
      "count": "#number",
      "total": "#number"
    }
    """

  Given request
    """
    {
      "fields": "symbol,symbolName,lastPrice,priceChange,percentChange,managedAssets.format(millions),tradeTime,quickLink",
      "lists": "funds.aum.tsx",
      "fieldCaptions": {
        "managedAssets": "AUM"
      }
    }
    """
  When method POST
  Then status 200
  And match response == fundListSchema
  And match response.count == 200
  And match response.total == 200
