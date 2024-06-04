from django.urls import path
from . import views

urlpatterns = [
    path("", views.index, name="ShopHome"),
    path("about/", views.about, name="AboutUs"),
    path("search/", views.search, name="Search"),
    path("products/<int:myid>", views.productview, name="Productview"),
]
