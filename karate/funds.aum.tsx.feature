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
  * def fundListSchema = read(`file:${root}/schema/fundlist.json`)

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
