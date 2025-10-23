#---------------------------------------------------------------------------------------------------
Feature: Sorting Positive Tests
#---------------------------------------------------------------------------------------------------

#---------------------------------------------------------------------------------------------------
Background:
#---------------------------------------------------------------------------------------------------

  * url baseUrl

#---------------------------------------------------------------------------------------------------
Scenario Outline: Sorting check per field <field>
#---------------------------------------------------------------------------------------------------

  * def fundSchema = read(`file:${root}/schema/fund.json`)
  * def fundListSchema = read(`file:${root}/schema/fundlist.json`)

  Given request
    """
    {
      "fields": "symbol,symbolName,lastPrice,priceChange,percentChange,managedAssets.format(millions),tradeTime,quickLink",
      "lists": "funds.aum.tsx",
      "fieldCaptions": {
        "managedAssets": "AUM"
      },
      "orderBy": "<field>",
      "orderDir": "asc"
    }
    """
  When method POST
  Then status 200
  And match response == fundListSchema
  # Sort the response data ourselves to confirm it did sort properly
  And def sortedResponse = karate.sort(response.data, <numbers> ? x => parseFloat(x.<field>) : x => x.<field>)
  And match response.data == sortedResponse

Examples:
  | field         | numbers |
  | symbol        | false   |
  | symbolName    | false   |
  | lastPrice     | true    |
  | priceChange   | true    |
  | percentChange | true    |
  | managedAssets | true    |
  | tradeTime     | false   |
