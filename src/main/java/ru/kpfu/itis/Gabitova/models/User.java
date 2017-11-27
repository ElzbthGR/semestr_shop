package ru.kpfu.itis.Gabitova.models;

public class User {

    private String name;
    private String email;
    private boolean isAdmin;

    public User(String name, String email, int isAdmin){
        this.name = name;
        this.email = email;
        this.isAdmin = isAdmin==1;
    }

    public String getName(){
        return name;
    }

    public String getEmail(){
        return email;
    }

    public boolean isAdmin(){
        return isAdmin;
    }

}
