package ru.kpfu.itis.Gabitova.models;

public class Product {

    private int id;
    private String title;
    private String description;
    private String dateCreate;
    private String photoUrl;
    private int price;

    public Product(int id, String title, String description, String dateCreate, String photoUrl, int price){
        this.id = id;
        this.title = title;
        this.description = description;
        this.dateCreate = dateCreate;
        this.photoUrl = photoUrl;
        this.price = price;
    }

    public int getId(){
        return id;
    }

    public String getTitle(){
        return title;
    }

    public String getDescription(){
        return description;
    }

    public String getDateCreate(){
        return dateCreate;
    }

    public String getPhotoUrl(){
        return photoUrl;
    }

    public int getPrice(){
        return price;
    }

}
