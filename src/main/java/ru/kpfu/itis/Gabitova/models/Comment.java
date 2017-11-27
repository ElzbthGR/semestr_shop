package ru.kpfu.itis.Gabitova.models;

public class Comment {

    private String nameUser;
    private String text;

    public Comment(String nameUser, String text){
        this.nameUser = nameUser;
        this.text = text;
    }

    public String getNameUser(){
        return nameUser;
    }

    public String getText(){
        return text;
    }
}
