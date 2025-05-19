# Acme Widget Co

## The Task

Acme Widget Co are the leading provider of made up widgets and they’ve contracted you to  create a proof of concept for their new sales system.


They sell three products:

| Product | Code | Price |
| ------- | ---- |------ |
| Red Widget | R01 | $32.95 |
| Green Widget | G01 | $24.95 |
| Blue Widget | B01 | $7.95 |

To incentivise customers to spend more, delivery costs are reduced based on the amount  spent. Orders under $50 cost $4.95. For orders under $90, delivery costs $2.95. Orders of $90 or more have free delivery.

They are also experimenting with special offers. The initial offer will be “buy one red widget, get the second half price”.

**Your job** is to implement the `Basket` which needs to have the following interface:

* It is initialised with the product catalogue, delivery charge rules, and offers (the format of how these are passed it up to you)
* It has an `add` method that takes the product code as a parameter.
* It has a `total` method that returns the total cost of the basket, taking into account  the delivery and offer rules.

Here are some example baskets and expected totals to help you check your  implementation.

| Products | Total  |
| -------- | ------ |
| B01, G01 | $37.85 |
| R01, R01 | $54.37 |
| R01, G01 | $60.85 |
| B01, B01, R01, R01, R01 | $98.27 |


What we expect to see

* A solution written in easy to understand Ruby code
* A README file explaining how it works and any assumptions you’ve made
* Pushed to a public Github repo

## Considerations

1. For the simplicity I decided to implement the task as a Rails project. Probably it is not what you expected. But there is no restriction.
1. Therefore the content of the product catalogue, delivery charge rules, and offers is being kept not in Arrays (I suppose that it is assumed) but rather in tables.
1. Indeed it is good when `Product#code` is the primary key. But I have left `#id`. Though this field is used for the association.
1. There is the requirement that `Basket#initialize` should have 3 parameters. But since the data required is being present in the database I see no need to send them explicitly. Instead the method takes a single parameter that is a Hash with the state of the Basket since in the real life the state of the `Basket` is being kept in cookie or in the database.
1. It is good to make model `DeliveryCost` to be versioned. I did not implement it.
1. I did not care about the views.
1. Indeed the `SpecialOffer`s may affect more than one `Product`. For the simplicity I assume that **only one** `Product` is affected by every `SpecialOffer`.
1. My own style guide may be not exact equal to yours. Do not mind it. I can use any.

## The requirements

The project uses Ruby 3.3.7.

## How to run the project

This project is not intended to be deployed in production. But you can run it locally.
To do that make the following:

1. Clone the project.
1. Change to the new cloned directory.
1. Ensure that your current version of Ruby is 3.3.7.
1. Ensure that the gem "bundle" is available.
1. Run the following commands

```
bundle install
bundle exec rails db:create
bundle exec rails db:migrate
bundle exec rails db:seeds
bundle exec rails server
```

## How to run the tests

To run the specs use the command `bundle exec rspec -c -fd`.

The project user the gem `guard`. Therefore to run all the tests run the command `bundle exec guard` and when the prompt have appeared just press the key "Enter".
