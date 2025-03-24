/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

public class CourseStat {

    private int courseID;
    private int memberCount;

    public CourseStat(int courseID, int memberCount) {
        this.courseID = courseID;
        this.memberCount = memberCount;
    }

    public int getCourseName() {
        return courseID;
    }

    public int getRegisteredCount() {
        return memberCount;
    }
}
