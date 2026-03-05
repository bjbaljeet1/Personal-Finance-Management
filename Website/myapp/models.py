from django.db import models

# Create your models here.


class Login(models.Model):
    username=models.CharField(max_length=100)
    password=models.CharField(max_length=100)
    type=models.CharField(max_length=100)

class Users(models.Model):
    name=models.CharField(max_length=100)
    Email=models.CharField(max_length=100)
    Contact=models.CharField(max_length=100)
    DOB=models.DateField()
    Gender=models.CharField(max_length=100)
    Place=models.CharField(max_length=100)
    Pin=models.CharField(max_length=100)
    Post=models.CharField(max_length=100)
    District=models.CharField(max_length=100)
    Photo=models.CharField(max_length=300)
    LOGIN=models.ForeignKey(Login,on_delete=models.CASCADE)

class Expert(models.Model):
    Expertname=models.CharField(max_length=100)
    Qualification=models.CharField(max_length=100)
    Experience=models.CharField(max_length=100)
    Gender=models.CharField(max_length=100)
    Phone=models.CharField(max_length=100)
    Email=models.CharField(max_length=100)
    Place=models.CharField(max_length=100)
    Status=models.CharField(max_length=100)
    Proof=models.CharField(max_length=200)
    Photo=models.CharField(max_length=300)
    LOGIN=models.ForeignKey(Login,on_delete=models.CASCADE)

class complaint(models.Model):
    USER=models.ForeignKey(Users,on_delete=models.CASCADE)
    Complaint=models.CharField(max_length=100)
    Date=models.DateField()
    Status=models.CharField(max_length=100)
    Reply=models.CharField(max_length=100)

class Budget(models.Model):
    USER=models.ForeignKey(Users,on_delete=models.CASCADE)
    Budget=models.CharField(max_length=100)
    Month=models.CharField(max_length=100)
    Year=models.CharField(max_length=100)


class ExpertReview(models.Model):
    USER=models.ForeignKey(Users,on_delete=models.CASCADE)
    Review=models.CharField(max_length=100)
    Rating=models.CharField(max_length=100)
    Date=models.CharField(max_length=100)
    EXPERT=models.ForeignKey(Expert,on_delete=models.CASCADE)

class App_Review(models.Model):
    USER=models.ForeignKey(Users,on_delete=models.CASCADE)
    Review=models.CharField(max_length=100)
    Rating=models.CharField(max_length=100)
    Date=models.CharField(max_length=100)

class Suggestions(models.Model):
    Date=models.CharField(max_length=100)
    Suggestions=models.CharField(max_length=100)
    Expert=models.ForeignKey(Expert,on_delete=models.CASCADE)
    USER=models.ForeignKey(Users,on_delete=models.CASCADE)

class Expenses(models.Model):
    Expenses=models.CharField(max_length=100)
    Month=models.CharField(max_length=100)
    Year=models.CharField(max_length=100)
    USER=models.ForeignKey(Users,on_delete=models.CASCADE)
    BUDGET=models.ForeignKey(Budget,on_delete=models.CASCADE)
    Date=models.DateField()
    Discription=models.CharField(max_length=100)
    Type=models.CharField(max_length=100,default='')


class Income(models.Model):
    USER=models.ForeignKey(Users,on_delete=models.CASCADE)
    Income=models.CharField(max_length=100)
    Sourceofincome=models.CharField(max_length=100)
    Date=models.DateField()


class Notification(models.Model):
    Date=models.CharField(max_length=100)
    USER = models.ForeignKey(Users, on_delete=models.CASCADE)
    Notification=models.CharField(max_length=100)

class Tax(models.Model):
    USER = models.ForeignKey(Users, on_delete=models.CASCADE)
    Tax_name=models.CharField(max_length=100)
    Tax_amount=models.CharField(max_length=100)
    Date = models.CharField(max_length=100)


class ExpertRequest(models.Model):
    date=models.CharField(max_length=100)
    USER=models.ForeignKey(Users,on_delete=models.CASCADE)
    EXPERT=models.ForeignKey(Expert,on_delete=models.CASCADE)
    Status=models.CharField(max_length=100)
    Enquiries=models.CharField(max_length=500)
    reply=models.CharField(max_length=1000)





