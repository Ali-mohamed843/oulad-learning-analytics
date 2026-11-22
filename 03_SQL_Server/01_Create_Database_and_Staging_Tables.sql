CREATE DATABASE Education
ON PRIMARY (NAME = Education_data, FILENAME = 'A:\SQLData\Education.mdf', SIZE = 64MB, FILEGROWTH = 64MB)
LOG ON     (NAME = Education_log,  FILENAME = 'A:\SQLData\Education_log.ldf', SIZE = 32MB, FILEGROWTH = 32MB);
GO

USE Education;
GO
CREATE SCHEMA stg;
GO
CREATE TABLE stg.Courses (
    code_module nvarchar(200), code_presentation nvarchar(200), module_presentation_length int);

CREATE TABLE stg.Vle (
    id_site int, code_module nvarchar(200), code_presentation nvarchar(200),
    activity_type nvarchar(200), week_from int, week_to int);

CREATE TABLE stg.Assessments (
    code_module nvarchar(200), code_presentation nvarchar(200), id_assessment int,
    assessment_type nvarchar(200), [date] int, weight float);

CREATE TABLE stg.StudentInfo (
    code_module nvarchar(200), code_presentation nvarchar(200), id_student int,
    gender nvarchar(10), region nvarchar(200), highest_education nvarchar(200),
    imd_band nvarchar(200), age_band nvarchar(200), num_of_prev_attempts int,
    studied_credits int, disability nvarchar(10), final_result nvarchar(200));

CREATE TABLE stg.StudentRegistration (
    code_module nvarchar(200), code_presentation nvarchar(200), id_student int,
    date_registration int, date_unregistration int);

CREATE TABLE stg.StudentAssessment (
    id_assessment int, id_student int, date_submitted int, is_banked int, score float);

CREATE TABLE stg.StudentVle (
    code_module nvarchar(200), code_presentation nvarchar(200), id_student int,
    id_site int, [date] int, sum_click int);

CREATE TABLE stg.Reject_StudentInfo (
    code_module nvarchar(200), code_presentation nvarchar(200), id_student int,
    gender nvarchar(10), region nvarchar(200), highest_education nvarchar(200),
    imd_band nvarchar(200), age_band nvarchar(200), num_of_prev_attempts int,
    studied_credits int, disability nvarchar(10), final_result nvarchar(200));

CREATE TABLE stg.Reject_StudentVle (
    code_module nvarchar(200), code_presentation nvarchar(200), id_student int,
    id_site int, [date] int, sum_click int);
