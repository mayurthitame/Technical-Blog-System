/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tech.blog.dao;

import java.sql.Connection;

/**
 *
 * @author mayur
 */
public class CategoryDao 
{
        private Connection con;

    public CategoryDao(Connection con) 
    {
        this.con = con;
    }

}
