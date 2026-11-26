USE Education;
GO
IF DB_NAME() <> N'Education' SET NOEXEC ON;
GO
DROP TABLE IF EXISTS dbo.Fact_VLE_Activity;
DROP TABLE IF EXISTS dbo.Fact_Assessment;
DROP TABLE IF EXISTS dbo.Fact_Enrollment;
DROP TABLE IF EXISTS dbo.Dim_Activity;
DROP TABLE IF EXISTS dbo.Dim_Assessment;
DROP TABLE IF EXISTS dbo.Dim_Student;
DROP TABLE IF EXISTS dbo.Dim_Course;
GO

CREATE TABLE dbo.Dim_Course (
    course_key int IDENTITY(1,1) CONSTRAINT PK_Dim_Course PRIMARY KEY,
    code_module nvarchar(10) NOT NULL,
    code_presentation nvarchar(10) NOT NULL,
    presentation_year int NULL,
    presentation_start nvarchar(10) NULL,
    module_presentation_length int NULL,
    CONSTRAINT UQ_Dim_Course UNIQUE (code_module, code_presentation));

CREATE TABLE dbo.Dim_Student (
    student_key int IDENTITY(1,1) CONSTRAINT PK_Dim_Student PRIMARY KEY,
    id_student int NOT NULL CONSTRAINT UQ_Dim_Student UNIQUE,
    gender nvarchar(10) NOT NULL,
    region nvarchar(100) NOT NULL,
    highest_education nvarchar(100) NOT NULL,
    imd_band nvarchar(20) NOT NULL,
    age_band nvarchar(20) NOT NULL,
    disability nvarchar(1) NOT NULL);

CREATE TABLE dbo.Dim_Assessment (
    assessment_key int IDENTITY(1,1) CONSTRAINT PK_Dim_Assessment PRIMARY KEY,
    id_assessment int NOT NULL CONSTRAINT UQ_Dim_Assessment UNIQUE,
    course_key int NOT NULL CONSTRAINT FK_DimAssessment_Course REFERENCES dbo.Dim_Course(course_key),
    assessment_type nvarchar(20) NULL,
    due_day int NULL,
    weight decimal(6,2) NULL);

CREATE TABLE dbo.Dim_Activity (
    activity_key int IDENTITY(1,1) CONSTRAINT PK_Dim_Activity PRIMARY KEY,
    id_site int NOT NULL CONSTRAINT UQ_Dim_Activity UNIQUE,
    course_key int NOT NULL CONSTRAINT FK_DimActivity_Course REFERENCES dbo.Dim_Course(course_key),
    activity_type nvarchar(50) NULL,
    week_from int NULL,
    week_to int NULL);

CREATE TABLE dbo.Fact_Enrollment (
    enrollment_key int IDENTITY(1,1) CONSTRAINT PK_Fact_Enrollment PRIMARY KEY,
    student_key int NOT NULL CONSTRAINT FK_FactEnr_Student REFERENCES dbo.Dim_Student(student_key),
    course_key int NOT NULL CONSTRAINT FK_FactEnr_Course REFERENCES dbo.Dim_Course(course_key),
    date_registration int NULL,
    date_unregistration int NULL,
    num_of_prev_attempts int NULL,
    studied_credits int NULL,
    final_result nvarchar(20) NOT NULL,
    is_withdrawn bit NOT NULL,
    is_passed bit NOT NULL,
    total_clicks int NOT NULL,
    assessments_submitted int NOT NULL,
    avg_score decimal(5,2) NULL);

CREATE TABLE dbo.Fact_Assessment (
    assessment_fact_key int IDENTITY(1,1) CONSTRAINT PK_Fact_Assessment PRIMARY KEY,
    student_key int NOT NULL CONSTRAINT FK_FactAss_Student REFERENCES dbo.Dim_Student(student_key),
    assessment_key int NOT NULL CONSTRAINT FK_FactAss_Assessment REFERENCES dbo.Dim_Assessment(assessment_key),
    course_key int NOT NULL CONSTRAINT FK_FactAss_Course REFERENCES dbo.Dim_Course(course_key),
    date_submitted int NULL,
    days_late int NULL,
    score decimal(5,2) NULL,
    is_banked bit NOT NULL);

CREATE TABLE dbo.Fact_VLE_Activity (
    vle_fact_key bigint IDENTITY(1,1) CONSTRAINT PK_Fact_VLE PRIMARY KEY,
    student_key int NOT NULL CONSTRAINT FK_FactVle_Student REFERENCES dbo.Dim_Student(student_key),
    course_key int NOT NULL CONSTRAINT FK_FactVle_Course REFERENCES dbo.Dim_Course(course_key),
    activity_key int NOT NULL CONSTRAINT FK_FactVle_Activity REFERENCES dbo.Dim_Activity(activity_key),
    activity_day int NOT NULL,
    sum_click int NOT NULL);
GO
SET NOEXEC OFF;
GO
IF DB_NAME() = N'Education' PRINT 'Star schema tables created (empty). Next: run S3_Build_Star_Schema.sql.'
ELSE PRINT 'FAILED: Education does not exist.';
