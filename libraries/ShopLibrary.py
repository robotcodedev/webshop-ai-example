"""Keywords that talk to the demo web shop."""

import random

from robot.api import logger
from robot.api.deco import keyword, library

USERS = {"alice": "secret", "bob": "secret"}
PRICES = {"coffee": 4.50, "tea": 3.20, "beans": 9.90, "mug": 12.00}


@library(scope="GLOBAL", auto_keywords=False)
class ShopLibrary:
    """Talks to the demo web shop: logging in, the cart and orders.

    The shop runs in memory, so the suites need no server.
    """

    def __init__(self) -> None:
        self._user: str | None = None
        self._cart: dict[str, int] = {}
        self._stock = {"coffee": 100, "tea": 50, "beans": 20, "mug": 0}
        self._orders: dict[str, str] = {}
        self._confirmed: set[str] = set()

    @keyword
    def log_in(self, user: str, password: str) -> None:
        """Logs ``user`` in. Fails if the password is wrong."""
        if USERS.get(user) != password:
            raise AssertionError(f"Wrong password for {user}")
        self._user = user
        self._cart.clear()

    @keyword
    def log_out(self) -> None:
        """Logs the current user out."""
        self._user = None

    @keyword
    def greeting(self) -> str:
        """Returns the greeting the shop shows the user who is logged in."""
        return f"Welcome back, {self._user}!"

    @keyword
    def current_user(self) -> str | None:
        """Returns the user who is logged in, or ``None``."""
        return self._user

    @keyword
    def price_of(self, product: str) -> float:
        """Returns the price of ``product`` in euros."""
        return PRICES[product]

    @keyword
    def put_in_cart(self, product: str, quantity: int = 1) -> None:
        """Puts ``quantity`` items of ``product`` into the cart."""
        self._cart[product] = self._cart.get(product, 0) + quantity
        logger.info(f"Cart: {self._cart}")

    @keyword
    def take_from_cart(self, product: str) -> None:
        """Takes ``product`` out of the cart."""
        self._cart.pop(product)

    @keyword
    def cart_items(self) -> dict[str, int]:
        """Returns the products in the cart and their quantities."""
        return dict(self._cart)

    @keyword
    def cart_total(self) -> float:
        """Returns the total price of the cart in euros."""
        return round(sum(PRICES[product] * quantity for product, quantity in self._cart.items()), 2)

    @keyword
    def place_order(self, product: str, quantity: int = 1, express: bool = False) -> str:
        """Places an order and returns its id. Fails if ``product`` is out of stock."""
        if self._stock.get(product, 0) < quantity:
            raise AssertionError(f"{product} is out of stock")
        self._stock[product] -= quantity
        order = f"order-{4711 + len(self._orders)}"
        self._orders[order] = "express" if express else "placed"
        return order

    @keyword
    def order_status(self, order: str) -> str:
        """Returns the status of ``order``: ``placed`` or ``express``."""
        # The warehouse confirms an express order a moment later.
        if self._orders[order] == "express" and order not in self._confirmed:
            self._confirmed.add(order)
            if random.random() < 0.5:
                return "placed"
        return self._orders[order]

    @keyword
    def search_products(self, text: str) -> list[str]:
        """Returns the products whose name contains ``text``."""
        return sorted(product for product in PRICES if text in product)
