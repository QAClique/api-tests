#---------------------------------------------------------------------------------------------------
Feature: Number of Funds and Fields Tests
#---------------------------------------------------------------------------------------------------

#---------------------------------------------------------------------------------------------------
Background:
#---------------------------------------------------------------------------------------------------

  * url baseUrl

#---------------------------------------------------------------------------------------------------
Scenario: Verify number of funds returned
#---------------------------------------------------------------------------------------------------

  * def randomFundNumber = Math.floor(Math.random() * 10) + 1

  Given request
    """
    {
      "fields": "symbol,symbolName,lastPrice,priceChange,percentChange",
      "lists": "funds.aum.tsx",
      "fieldCaptions": {
        "managedAssets": "AUM"
      },
      "limit": #(randomFundNumber)
    }
    """
  When method POST
  Then status 200
  And match response.count == randomFundNumber
  And assert response.data.length == randomFundNumber

#---------------------------------------------------------------------------------------------------
Scenario Outline: Verify field <field> is returned
#---------------------------------------------------------------------------------------------------

  * def fundSchema = read(`file:${root}/schema/fund.json`)
  * def fundListSchema = read(`file:${root}/schema/fundlist.json`)

  Given request
    """
    {
      "fields": "<field>",
      "lists": "funds.aum.tsx",
      "fieldCaptions": {
        "managedAssets": "AUM"
      },
      "limit": 3
    }
    """
  When method POST
  Then status 200
  And match each response.data[*].<field> == "#present"

Examples:
  | field         |
  | symbol        |
  | symbolName    |
  | lastPrice     |
  | priceChange   |
  | percentChange |
  | managedAssets |
  | tradeTime     |
  | quickLink     |

#---------------------------------------------------------------------------------------------------
Scenario: Verify all fields are returned
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
      "limit": 10
    }
    """
  When method POST
  Then status 200
  And match response == fundListSchema
  And match response.total == 200

#---------------------------------------------------------------------------------------------------
Scenario: Default limit
#---------------------------------------------------------------------------------------------------

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
  And match response.count == 200
  And assert response.data.length == 200
