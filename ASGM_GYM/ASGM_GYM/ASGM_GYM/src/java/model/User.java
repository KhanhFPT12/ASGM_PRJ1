/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

public class User {
  private int id; 
    private String username; 
    private String email; 
    private String country; 
    private String phone ; 
    private String role; 
    private boolean status; 
    private String password; 
   

    public User() {
      
    }

    public User(int id, String username, String email, String country, String phone, String role, boolean status, String password) {
        this.id = id;
        this.username = username;
        this.email = email;
        this.country = country;
        this.phone = phone;
        this.role = role;
        this.status = status;
        this.password = password;
      
    }

    public User(int id, String username, String email, String country, String phone) {
        this.id = id;
        this.username = username;
        this.email = email;
        this.country = country;
        this.phone = phone;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }
  

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Override
    public String toString() {
        return "User{" + "id=" + id + ", username=" + username + ", email=" + email + ", country=" + country + ", phone=" + phone + ", role=" + role + ", status=" + status + ", password=" + password + '}';
    }

}
