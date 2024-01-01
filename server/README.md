# **INSTALL**
## 1. Environment
- Jdk17 or later: [Download JDK](https://www.oracle.com/java/technologies/downloads/) and import it to your project
## 2. Create application.properties file
- In src/main, create directory resources
- In src/main/resources, create application.properties
## 3. SQL
- [Download MySql](https://www.mysql.com/downloads/) or [A sample free MySql](https://www.freemysqlhosting.net/)
- If you use local MySql, should create a database for this project
- If you use a free Hosting Sql, They will give you _database name, username, password_
- Add to application.properties your 
```
    spring.jpa.hibernate.ddl-auto=update
    spring.jpa.show-sql=true
    spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.MySQL8Dialect
    spring.jpa.properties.hibernate.format_sql=true
    spring.jpa.database=mysql
    
    spring.datasource.username= [Your username here]
    spring.datasource.password= [Your password here]
    spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver
```

- If you use local MySql, add this:
```
    spring.datasource.url=jdbc:mysql://localhost:3306/[Your database you've create]
```
Example
```
    spring.datasource.url=jdbc:mysql://localhost:3306/volunteer
```

   - If you use Hosting free, add this:
```
    spring.datasource.url= [Link to your database here]
```
## 4. STMP 
- I am using Gmail's SMTP, simple enable:
  - Goto your account management 
  - Security 
  - 2-Step Verification
  - App passwords
  - Create an app password
  - App password like "abcd efgh ijkl mnop"
  - Goto your gmail -> All settings -> Turn on POP/IMAP
  - Push these properties in your application.properties:
```
    spring.mail.host=smtp.gmail.com
    spring.mail.port=587
    spring.mail.username= [your email here]
    spring.mail.password= [your app password here]
    spring.mail.properties.mail.smtp.auth=true
    spring.mail.properties.mail.smtp.starttls.enable=true
```
## 5. Image Store
- You shouldn't store user image in local, use [Cloudinary](..%2F..%2F..%2F..%2F..%2FAppData%2FLocal%2FTemp%2FImage%20and%20Video%20Upload%2C%20Storage%2C%20Optimization%20and%20CDN.url) for free
- After registration, You have _Cloud Name, API Key, API Secret_
- Easy push to application.properties:
```
    cloudinary.cloud_name= [your Cloud Name here]
    cloudinary.api_key= [Your API Key here]
    cloudinary.api_secret= [Your API Secret here]
```

## 6. Start
- Run
```
    src/main/java/vn/edu/hust/volunteer_app/VolunteerApplication.java
```


