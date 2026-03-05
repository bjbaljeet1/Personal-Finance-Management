from django.core.files.storage import FileSystemStorage
from django.db.models.functions import ExtractMonth, ExtractYear
from django.http import HttpResponse, JsonResponse
from django.shortcuts import render
from datetime import datetime
# Create your views here.
from myapp.models import *
from datetime import datetime

def admin_home(request):
    return render(request,"Admin/Adminindex2.html")

def login_get(request):
    return render(request,"login index.html")

def login_post(request):
    user=request.POST['username']
    password=request.POST['password']
    lg=Login.objects.filter(username=user,password=password)
    if lg.exists():
        lg1=Login.objects.get(username=user,password=password)
        request.session['lid']=lg1.id
        if lg1.type=='admin':
            return HttpResponse("<script>alert('Login sucess');window.location='/myapp/admin_home/'</script>")
        elif lg1.type == 'expert':
            return HttpResponse("<script>alert('Login sucess');window.location='/myapp/expert_home/'</script>")
        else:
            return HttpResponse("<script>alert('Invalid ');window.location='/myapp/login_get/'</script>")

    else:
        return HttpResponse("<script>alert('Not found');window.location='/myapp/login_get/'</script>")



def add_user_get(request):
    return render(request,"admin/Add user.html")

def add_user_post(request):
    username=request.POST['textfield']
    email=request.POST['textfield2']
    Contact=request.POST['textfield3']
    DOB=request.POST['textfield4']
    Place=request.POST['textfield5']
    PIN=request.POST['textfield6']
    District=request.POST['textfield7']
    Post=request.POST['textfield8']
    Photo=request.FILES['textfield9']
    fs=FileSystemStorage()

    date=datetime.now().strftime('%Y&m%d-%H%M&S')+'.jpg'
    fs.save(date,Photo)
    path=fs.url(date)

    l=Login()

    l.username=email
    import random

    psw=random.randint(0000,9999)
    l.password=psw
    l.type='user'
    l.save()

    obj=User()
    obj.name=username
    obj.Email=email
    obj.Contact=Contact
    obj.DOB=DOB
    obj.Place=Place
    obj.Pin=PIN
    obj.District=District
    obj.Post=Post
    obj.Photo=path
    obj.LOGIN=l
    obj.save()
    return HttpResponse("<script>alert('Add user');window.location='/myapp/admin_home/'</script>")


def edit_user_get(request,id):
    obj = User.objects.get(id=id)
    return render(request,"admin/Edit user.html",{"data":obj})



def edit_user_post(request):
    username=request.POST['textfield']
    email=request.POST['textfield2']
    Contact=request.POST['textfield3']
    DOB=request.POST['textfield4']
    Place=request.POST['textfield5']
    PIN=request.POST['textfield6']
    District=request.POST['textfield7']
    Post=request.POST['textfield8']
    id=request.POST['id']

    obj = User.objects.get(id=id)
    if 'textfield9' in request.FILES:
        Photo = request.FILES['textfield9']

        fs=FileSystemStorage()
        date=datetime.now().strftime('%Y&m%d-%H%M&S')+'.jpg'
        fs.save(date,Photo)
        path=fs.url(date)
        obj.Photo=path
        obj.save()

    obj.name=username
    obj.Email=email
    obj.Contact=Contact
    obj.DOB=DOB
    obj.Place=Place
    obj.Pin=PIN
    obj.Post=Post
    obj.District=District
    obj.save()
    return HttpResponse("<script>alert('Edit user');window.location='/myapp/AdminUserViews_get/'</script>")


def AdminUserViews_get(request):
    obj=Users.objects.all()

    return render(request,"admin/Admin_user_views.html",{'data':obj})

def AdminUserViews_post(request):
    search=request.POST['search']
    obj=User.objects.filter(name__icontains=search)
    return render(request,"admin/Admin_user_views.html",{'data':obj})


def admin_delete_user(request,id):
    User.objects.get(id=id).delete()
    return HttpResponse("<script>alert('Deleted sucessfully');window.location='/myapp/AdminUserViews_get/'</script>")


def add_expert_get(request):

    return render(request,"admin/Add expert.html")

def add_expert_post(request):
    Name=request.POST['textfield']
    Qualification=request.POST['textfield2']
    Experience=request.POST['textfield3']
    Gender=request.POST['textfield4']
    Phone=request.POST['textfield5']
    Email=request.POST['textfield6']
    Place=request.POST['textfield7']

    obj=Expert()
    obj.Expertname=Name
    obj.Qualification=Qualification
    obj.Experience=Experience
    obj.Gender=Gender
    obj.Phone=Phone
    obj.Email=Email
    obj.Place=Place
    obj.save()

    return HttpResponse("<script>alert('Add sucess');window.location='/myapp/admin_home/'</script>")


def edit_expert_get(request,id):
    obj=Expert.objects.get(id=id)
    return render(request,"admin/Edit expert.html",{"data":obj})


def edit_expert_post(request):
    Name=request.POST['textfield']
    Qualification=request.POST['textfield2']
    Experience=request.POST['textfield3']
    Gender=request.POST['textfield4']
    Phone=request.POST['textfield5']
    Email=request.POST['textfield6']
    Place=request.POST['textfield7']
    id=request.POST['id']

    obj=Expert.objects.get(id=id)
    obj.Expertname=Name
    obj.Qualification=Qualification
    obj.Experience=Experience
    obj.Gender=Gender
    obj.Phone=Phone
    obj.Email=Email
    obj.Place=Place
    obj.save()

    return HttpResponse("<script>alert('Add sucess');window.location='/myapp/Admin_expert_views_get/'</script>")

def Admin_expert_views_get(request):
    obj=Expert.objects.filter(Status="Pending")
    return render(request,"admin/Admin_expert_views.html",{"data":obj})

def Admin_view_approved_expert_get(request):
    obj=Expert.objects.filter(Status="Approved")
    return render(request,"admin/Admin_view_approved_expert.html",{"data":obj})

def Admin_view_approved_expert_post(request):
    search=request.POST['textfield']
    obj=Expert.objects.filter(Status="Approved",Expertname__icontains=search)
    return render(request,"admin/Admin_view_approved_expert.html",{"data":obj})


def Admin_view_rejected_expert_get(request):
    obj=Expert.objects.filter(Status="Rejected")
    return render(request,"admin/Admin_view_rejected_expert.html",{"data":obj})

def Admin_view_rejected_expert_post(request):
    search=request.POST['textfield']
    obj=Expert.objects.filter(Status="Rejected")
    return render(request,"admin/Admin_view_rejected_expert.html",{"data":obj})

def Approve_expert(request,id):
     b=Expert.objects.filter(LOGIN=id).update(Status="Approved")
     c=Login.objects.filter(id=id).update(type="expert")
     return HttpResponse("<script>alert('Approved successfully');window.location='/myapp/Admin_expert_views_get/'</script>")

def Reject_expert(request,id):
    d=Expert.objects.filter(LOGIN=id).update(Status="Rejected")
    e= Login.objects.filter(id=id).update(type="Rejected")
    return HttpResponse("<script>alert('Rejected');window.location='/myapp/Admin_expert_views_get/'</script>")


def Admin_expert_views_post(request):
    search = request.POST['textfield']
    obj=Expert.objects.filter(Expertname=search,Status="Pending")

    return render(request,"admin/Admin_expert_views.html",{"data":obj})



def Admin_view_approved_expert_post(request):
    search=request.POST['textfield']
    obj=Expert.objects.filter(Status="Approved",Expertname=search)
    return render(request,"admin/Admin_view_approved_expert.html",{"data":obj})


def Admin_view_rejected_expert_post(request):
    search=request.POST['textfield']
    obj=Expert.objects.filter(Status="Rejected",Expertname=search)
    return render(request,"admin/Admin_view_rejected_expert.html",{"data":obj})



def admin_delete_expert(request,id):
    Expert.objects.get(id=id).delete()

    return HttpResponse("<script>alert('Deleted sucessfully');window.location='/myapp/Admin_expert_views_get/'</script>")


def AdminViewComplain_get(request):
    c=complaint.objects.all()
    return render(request,"admin/admin_view_complaint.html",{"data":c})

def AdminViewComplain_post(request):
    From=request.POST['textfield']
    to=request.POST['textfield2']

    c=complaint.objects.filter(Date__range=[From,to])
    return render(request,"admin/admin_view_complaint.html",{"data":c})

def ChangePassword_get(request):
    return render(request,"admin/Change_password.html")

def ChangePassword_post(request):
    currentpass=request.POST['currentpassword']
    changepass=request.POST['changepassword']
    confirmpass=request.POST['confirmpassword']

    id=request.session['lid']
    l=Login.objects.get(id=id)
    if l.password==currentpass:
        if changepass==confirmpass:
            Login.objects.filter(id=id).update(password=confirmpass)
            return HttpResponse("<script>alert('Password changed sucessfully');window.location='/myapp/login_get/'</script>")
        else:
            return HttpResponse("<script>alert('Password mismatched');window.location='/myapp/ChangePassword_get/'</script>")
    else:
        return HttpResponse( "<script>alert('Check your current password');window.location='/myapp/ChangePassword_get/'</script>")


def SendReply_get(request,id):
    return render(request,"admin/send_reply.html",{"id":id})

def SendReply_post(request):

    reply=request.POST['textarea']
    id=request.POST['id']
    a=complaint.objects.filter(id=id).update(Status="Replied",Reply=reply)

    return HttpResponse("<script>alert('Replied sucessfully');window.location='/myapp/AdminViewsComplain_get/'</script>")



#####################

def expert_signup(request):
    return render(request,'Expert/signupindex.html')


def expert_signup_post(request):
    name=request.POST['name']
    Qualification=request.POST['qualification']
    Photo=request.FILES['photo']
    Experiance=request.POST['experience']
    Gender=request.POST['gender']
    Phone=request.POST['phone']
    Email=request.POST['email']
    Place=request.POST['place']
    Proof=request.FILES['proof']
    Password=request.POST['password']
    Confirm_Password=request.POST['confirmpassword']

    if Password==Confirm_Password:
        lobj = Login()
        lobj.username = Email
        lobj.password = Password
        lobj.type = 'Pending'
        lobj.save()

        fs=FileSystemStorage()
        date=datetime.now().strftime('%Y%m%d-%H%M%S')+'.jpg'
        fs.save(date,Photo)
        path=fs.url(date)


        date1=datetime.now().strftime('%Y%m%d-%H%M%S')+'.pdf'
        fs.save(date1,Proof)
        path1=fs.url(date1)



        robj=Expert()
        robj.Expertname=name
        robj.Qualification=Qualification
        robj.Experience=Experiance
        robj.Gender=Gender
        robj.Phone=Phone
        robj.Email=Email
        robj.Place=Place
        robj.Status='Pending'
        robj.Photo=path
        robj.Proof=path1
        robj.LOGIN=lobj
        robj.save()
        return HttpResponse("<script>alert('Sign Up sucessfully');window.location='/myapp/login_get'</script>")
    else:
        return HttpResponse("<script>alert('Password is mismatch');window.location='/myapp/login_get'</script>")


def expert_home(request):
    return render(request,"Expert/Expertindex2.html")



def send_suggestion(request):
    return render(request,"Expert/Enquiries.html")


def send_suggestion_Post(request):
    suggestion=request.POST['suggestion']
    sobj=Suggestions()
    sobj.Date=datetime.now()
    sobj.Suggestions=suggestion
    sobj.Expert=Expert.objects.get(LOGIN_id=request.session['lid'])
    sobj.save()

    return HttpResponse("<script>alert('Send sucessfully');window.location='/myapp/expert_home'</script>")


def Expert_ChangePassword_get(request):
    return render(request,"Expert/Change_password.html")

def Expert_ChangePassword_post(request):
    currentpass=request.POST['currentpassword']
    changepass=request.POST['changepassword']
    confirmpass=request.POST['confirmpassword']

    id=request.session['lid']
    l=Login.objects.get(id=id)
    if l.password==currentpass:
        if changepass==confirmpass:
            Login.objects.filter(id=id).update(password=confirmpass)
            return HttpResponse("<script>alert('Password changed sucessfully');window.location='/myapp/login_get/'</script>")
        else:
            return HttpResponse("<script>alert('Password mismatched');window.location='/myapp/Expert_ChangePassword_get/'</script>")
    else:
        return HttpResponse( "<script>alert('Check your current password');window.location='/myapp/Expert_ChangePassword_get/'</script>")



def Expert_view_profile(request):
    ex=Expert.objects.get(LOGIN=request.session['lid'])
    return render(request,'Expert/view_profile.html',{'data':ex})




def Expert_Edit_profile(request):
    ex=Expert.objects.get(LOGIN=request.session['lid'])

    return render(request,'Expert/Edit_profile.html',{'data':ex})


def Expert_Edit_profile_post(request):
    name=request.POST['name']
    Qualification=request.POST['qualification']
    Experiance=request.POST['experience']
    Gender=request.POST['gender']
    Phone=request.POST['phone']
    Email=request.POST['email']
    Place=request.POST['place']
    robj=Expert.objects.get(LOGIN=request.session['lid'])

    if 'photo' in request.FILES:
        Photo = request.FILES['photo']

        fs=FileSystemStorage()
        date=datetime.now().strftime('%Y%m%d-%H%M%S')+'.jpg'
        fs.save(date,Photo)
        path=fs.url(date)
        robj.Photo = path
        robj.save()

    if 'proof' in request.FILES:
        Proof = request.FILES['proof']

        fs=FileSystemStorage()
        date1=datetime.now().strftime('%Y%m%d-%H%M%S')+'.pdf'
        fs.save(date1,Proof)
        path1=fs.url(date1)
        robj.Proof = path1
        robj.save()

    robj.Expertname=name
    robj.Qualification=Qualification
    robj.Experience=Experiance
    robj.Gender=Gender
    robj.Phone=Phone
    robj.Email=Email
    robj.Place=Place
    robj.save()


    return HttpResponse("<script>alert('Edited sucessfully');window.location='/myapp/Expert_view_profile/'</script>")


###############


def user_login_post(request):
    username=request.POST['name']
    password=request.POST['password']
    lg = Login.objects.filter(username=username, password=password)
    if lg.exists():
        lg1 = Login.objects.get(username=username, password=password)
        lid= lg1.id
        if lg1.type == 'user':
            uname=Users.objects.get(LOGIN__id=lid).name
            uphoto=Users.objects.get(LOGIN__id=lid).Photo
            print(uphoto)
            return JsonResponse({'status': 'ok','lid':str(lid),"uname":uname,"uphoto":uphoto})
        else:
            return JsonResponse({'status': 'no'})
    else:
        return JsonResponse({'status': 'no'})

def user_signup(request):
    name=request.POST['name']
    DOB=request.POST['dob']
    Email=request.POST['email']
    Contact=request.POST['contact']
    Place=request.POST['place']
    Pin=request.POST['pin']
    Gender=request.POST['gender']
    District=request.POST['district']
    Post=request.POST['post']
    Photo=request.POST['photo']
    password=request.POST['password']
    confirm=request.POST['confirm']

    l=Login()

    l.username=Email
    l.password=password
    l.type='user'
    l.save()

    import base64
    date=datetime.now().strftime('%Y%m%d%H%M%S')+'.jpg'
    abc=base64.b64decode(Photo)


    fs=open("C:\\Users\\HP\\PycharmProjects\\PFM\\media\\"+date,"wb")
    path='/media/'+date
    fs.write(abc)
    fs.close()

    obj=Users()
    obj.name=name
    obj.Email=Email
    obj.Contact=Contact
    obj.DOB=DOB
    obj.Place=Place
    obj.Gender=Gender
    obj.Photo=path
    obj.Pin=Pin
    obj.District=District
    obj.Post=Post
    obj.LOGIN=l
    obj.save()
    return JsonResponse({'status':'ok'})

def user_change_password(request):

    oldpassword=request.POST['oldpassword']
    newpassword=request.POST['newpassword']
    confirmpassword=request.POST['confirmpassword']
    lid=request.POST['lid']
    b=Login.objects.filter(id=lid,password=oldpassword)
    if b.exists():
        Login.objects.get(id=lid,password=oldpassword)
        if newpassword==confirmpassword:
            c=Login.objects.filter(id=lid).update(password=confirmpassword)
            return JsonResponse({'status':'ok'})
        else:
            return JsonResponse({'status':'no'})
    else:
        return JsonResponse({'status':'no'})

def user_profile(request):
    lid=request.POST['lid']

    print(lid
          )



    uu=Users.objects.get(LOGIN_id=lid)

    return JsonResponse({"status":"ok","name":uu.name,"Email":uu.Email,
                         "Contact":uu.Contact,"DOB":uu.DOB,"Place":uu.Place,
                         "Pin":uu.Pin,"Post":uu.Post,
                         "District":uu.District,"Photo":uu.Photo,"Gender":uu.Gender})

def user_edit_profile(request):
    name=request.POST['name']
    dob=request.POST['dob']
    email=request.POST['email']
    contact=request.POST['contact']
    place=request.POST['place']
    pin=request.POST['pin']
    district=request.POST['district']
    gender=request.POST['gender']
    post=request.POST['post']
    photo=request.POST['photo']
    lid=request.POST['lid']
    obj = Users.objects.get(LOGIN__id=lid)

    if len(photo)>0:
        import base64
        date = datetime.now().strftime('%Y%m%d%H%M%S') + '.jpg'
        abc = base64.b64decode(photo)
        fs = open("C:\\Users\\HP\\PycharmProjects\\PFM\\media\\" + date, "wb")
        path = '/media/' + date
        fs.write(abc)
        fs.close()
        obj.Photo = path
        obj.save()



    obj.name = name
    obj.Email = email
    obj.Contact = contact
    obj.DOB = dob
    obj.Place = place
    obj.Pin = pin
    obj.District = district
    obj.Post = post
    obj.Gender=gender
    obj.save()


    Login.objects.filter(id=lid).update(username=email)
    return JsonResponse({'status':'ok'})


from datetime import datetime
from django.http import JsonResponse
from .models import Budget, Expenses, Users


# def user_expenses(request):
#     try:
#         expense = int(request.POST['Expense'])
#         description = request.POST['discription']  # Keep same key if front-end uses it
#         category = request.POST['category']
#         month = request.POST['month']
#         year = request.POST['year']
#         budget_id = request.POST['bid']
#         lid = request.POST['lid']
#
#         # Fetch budget object safely
#         from datetime import datetime
#         x = datetime.now()
#
#         print(x.strftime("%B"))
#         month=x.strftime("%B")
#         print(month)
#
#         year=x.strftime("%Y")
#         budget_obj = Budget.objects.filter(USER__LOGIN_id=lid, Month=month, Year=year)
#         print(budget_obj,'uuuuuuuuu')
#         if not budget_obj:
#             print("aaaaaaaaaaaaaaaaa")
#             return JsonResponse({'status': 'no', 'message': 'Budget not found'})
#
#         available_budget = int(budget_obj.Budget)
#
#
#         # Convert to integer for comparison
#
#         # Expense should not exceed the budget
#         if expense > available_budget:
#             print("qqqqqqqqqqqqqqqqq")
#             return JsonResponse({'status': 'no', 'message': 'Expense exceeds budget'})
#         print("asdfghj")
#         # Save the expense
#         obj = Expenses()
#         obj.Expenses = expense
#         obj.Discription = description  # Consider renaming this to 'Description' in the model
#         obj.Date = datetime.now()
#         obj.Month = month
#         obj.Year = year
#         obj.BUDGET_id = budget_id
#         obj.Type = category
#         obj.USER = Users.objects.get(LOGIN=lid)
#         obj.save()
#
#         return JsonResponse({'status': 'ok'})
#
#     except Exception as e:
#         return JsonResponse({'status': 'no', 'message': str(e)})

#
# def user_expenses(request):
#     try:
#         # Extract data from the request
#         expense = float(request.POST.get('Expense', 0))  # Convert to float first
#         description = request.POST.get('discription', '')
#         category = request.POST.get('category', '')
#         budget_id = request.POST.get('bid', '')
#         lid = request.POST.get('lid', '')
#         month = request.POST.get('month', '')
#         year = request.POST.get('year', '')
#
#         # Validate required fields
#         if not all([expense, description, category, budget_id, lid, month, year]):
#             return JsonResponse({'status': 'no', 'message': 'Missing required fields'})
#
#         # Fetch the budget object
#         budget_obj = Budget.objects.filter(
#             id=budget_id,
#             USER__LOGIN_id=lid
#         ).first()
#
#         if not budget_obj:
#             return JsonResponse({'status': 'no', 'message': 'Budget not found'})
#
#         # Calculate the total expenses for the current budget
#         total_expenses = Expenses.objects.filter(BUDGET=budget_obj).aggregate(total=Sum('Expenses'))['total'] or 0
#         available_budget = float(budget_obj.Budget) - total_expenses
#
#         # Check for negative expense and send a notification
#         if expense < 0:
#             notification = Notification(
#                 Date=datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
#                 USER=budget_obj.USER,
#                 Notification=f"Negative expense detected: {expense}. Please review!"
#             )
#             notification.save()
#             return JsonResponse({
#                 'status': 'no',
#                 'message': f'Negative expense not allowed: {expense}'
#             })
#
#         # Save the expense regardless of under or over budget
#         expense_obj = Expenses(
#             Expenses=expense,
#             Discription=description,
#             Date=datetime.now(),
#             Month=month,
#             Year=year,
#             BUDGET=budget_obj,
#             Type=category,
#             USER=budget_obj.USER
#         )
#         expense_obj.save()
#
#         # Notify if the expense exceeds the budget
#         if expense > available_budget:
#             notification = Notification(
#                 Date=datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
#                 USER=budget_obj.USER,
#                 Notification=f"Expense exceeded the budget! Remaining budget: {available_budget - expense}"
#             )
#             notification.save()
#             return JsonResponse({
#                 'status': 'no',
#                 'message': f'Expense exceeds budget. Remaining budget: {available_budget - expense}'
#             })
#
#         return JsonResponse({'status': 'ok', 'message': 'Expense added successfully'})
#
#     except Exception as e:
#         return JsonResponse({'status': 'no', 'message': str(e)})
#
#
#




from django.db.models import Sum
from django.http import JsonResponse
from datetime import datetime
#
# def user_expenses(request):
#     try:
#         # Extract data from the request
#         expense = float(request.POST.get('Expense', 0))  # Convert to float first
#         description = request.POST.get('discription', '')
#         category = request.POST.get('category', '')
#         budget_id = request.POST.get('bid', '')
#         lid = request.POST.get('lid', '')
#         month = request.POST.get('month', '')
#         year = request.POST.get('year', '')
#
#         # Validate required fields
#         if not all([expense, description, category, budget_id, lid, month, year]):
#             return JsonResponse({'status': 'no', 'message': 'Missing required fields'})
#
#         # Fetch the budget object
#         budget_obj = Budget.objects.filter(
#             id=budget_id,
#             USER__LOGIN_id=lid
#         ).first()
#
#         if not budget_obj:
#             return JsonResponse({'status': 'no', 'message': 'Budget not found'})
#
#         # Calculate the total expenses for the current budget
#         total_expenses = Expenses.objects.filter(BUDGET=budget_obj).aggregate(total=Sum('Expenses'))['total'] or 0
#         available_budget = float(budget_obj.Budget) - total_expenses
#
#         # Check for negative expense and send a notification
#         if expense < 0:
#             notification = Notification(
#                 Date=datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
#                 USER=budget_obj.USER,
#                 Notification=f"Negative expense detected: {expense}. Please review!"
#             )
#             notification.save()
#             return JsonResponse({
#                 'status': 'no',
#                 'message': f'Negative expense not allowed: {expense}'
#             })
#
#         # Save the expense regardless of under or over budget
#         expense_obj = Expenses(
#             Expenses=expense,
#             Discription=description,
#             Date=datetime.now(),
#             Month=month,
#             Year=year,
#             BUDGET=budget_obj,
#             Type=category,
#             USER=budget_obj.USER
#         )
#         expense_obj.save()
#
#         # Calculate the remaining budget after adding the new expense
#         remaining_budget = available_budget - expense
#
#         # Notify if the remaining budget is exactly 1000
#         if remaining_budget == 1000:
#             notification = Notification(
#                 Date=datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
#                 USER=budget_obj.USER,
#                 Notification=f"Remaining budget is 1000. Please review your expenses."
#             )
#             notification.save()
#
#         # Notify if the expense exceeds the budget
#         if expense > available_budget:
#             notification = Notification(
#                 Date=datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
#                 USER=budget_obj.USER,
#                 Notification=f"Expense exceeded the budget! Remaining budget: {remaining_budget}"
#             )
#             notification.save()
#             return JsonResponse({
#                 'status': 'no',
#                 'message': f'Expense exceeds budget. Remaining budget: {remaining_budget}'
#             })
#
#         return JsonResponse({'status': 'ok', 'message': 'Expense added successfully'})
#
#     except Exception as e:
#         return JsonResponse({'status': 'no', 'message': str(e)})
#
#
#


def user_expenses(request):
    try:
        # Extract data from the request
        expense = float(request.POST.get('Expense', 0))  # Convert to float first
        description = request.POST.get('discription', '')
        category = request.POST.get('category', '')
        budget_id = request.POST.get('bid', '')
        lid = request.POST.get('lid', '')
        month = request.POST.get('month', '')
        year = request.POST.get('year', '')

        # Validate required fields
        if not all([expense, description, category, budget_id, lid, month, year]):
            return JsonResponse({'status': 'no', 'message': 'Missing required fields'})

        # Fetch the budget object
        budget_obj = Budget.objects.filter(
            id=budget_id,
            USER__LOGIN_id=lid
        ).first()

        if not budget_obj:
            return JsonResponse({'status': 'no', 'message': 'Budget not found'})

        # Calculate the total expenses for the current budget
        total_expenses = Expenses.objects.filter(BUDGET=budget_obj).aggregate(total=Sum('Expenses'))['total'] or 0
        available_budget = float(budget_obj.Budget) - total_expenses

        # Check for negative expense and send a notification
        if expense < 0:
            notification = Notification(
                Date=datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
                USER=budget_obj.USER,
                Notification=f"Negative expense detected: {expense}. Please review!"
            )
            notification.save()
            return JsonResponse({
                'status': 'no',
                'message': f'Negative expense not allowed: {expense}'
            })

        # Save the expense regardless of under or over budget
        expense_obj = Expenses(
            Expenses=expense,
            Discription=description,
            Date=datetime.now(),
            Month=month,
            Year=year,
            BUDGET=budget_obj,
            Type=category,
            USER=budget_obj.USER
        )
        expense_obj.save()

        # Calculate the remaining budget after adding the new expense
        remaining_budget = available_budget - expense

        # Send a notification with the remaining balance
        notification_message = f"Remaining budget after expense: {remaining_budget}"
        if remaining_budget < 0:
            notification_message = f"Budget exceeded! Negative balance: {remaining_budget}"

        notification = Notification(
            Date=datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
            USER=budget_obj.USER,
            Notification=notification_message
        )
        notification.save()

        # Return appropriate response
        if remaining_budget < 0:
            return JsonResponse({
                'status': 'no',
                'message': f'Expense exceeds budget. Negative balance: {remaining_budget}'
            })
        else:
            return JsonResponse({
                'status': 'ok',
                'message': f'Expense added successfully. Remaining budget: {remaining_budget}'
            })

    except Exception as e:
        return JsonResponse({'status': 'no', 'message': str(e)})



# def user_expenses(request):
#     expense=request.POST['Expense']
#     discription=request.POST['discription']
#     category=request.POST['category']
#     month=request.POST['month']
#     year=request.POST['year']
#     budget=request.POST['bid']
#     lid=request.POST['lid']
#     from datetime import datetime
#     s=Budget.objects.get(USER__LOGIN_id=lid,Month=currentdate).Budget
#
#     if str(s)>expense:
#         return JsonResponse({'status':'no'})
#
#     obj=Expenses()
#     obj.Expenses=expense
#     obj.Discription=discription
#     obj.Date=datetime.now().today()
#     obj.Month=month
#     obj.Year=year
#     obj.BUDGET_id=budget
#     obj.Type=category
#     obj.USER=Users.objects.get(LOGIN=lid)
#     obj.save()
#
#     return JsonResponse({'status':'ok'})

def user_budget_manage(request):
    try:
        # Extract data from the request
        budget = request.POST['budget']
        Month = request.POST['month']
        Year = request.POST['year']
        lid = request.POST['lid']

        # Check if a budget already exists for the given user, month, and year
        existing_budget = Budget.objects.filter(
            USER__LOGIN=lid,
            Month=Month,
            Year=Year
        ).first()

        if existing_budget:
            # If budget exists, return a message indicating so
            return JsonResponse({'status': 'no', 'message': 'Budget for this month already exists'})

        # If no budget exists, save the new budget
        obj = Budget()
        obj.USER = Users.objects.get(LOGIN=lid)
        obj.Budget = budget
        obj.Month = Month
        obj.Year = Year
        obj.save()

        return JsonResponse({'status': 'ok', 'message': 'Budget added successfully'})

    except Exception as e:
        # Handle exceptions and return an error message
        return JsonResponse({'status': 'no', 'message': str(e)})


def user_view_budget(request):
    lid=request.POST['lid']
    bud=Budget.objects.filter(USER__LOGIN_id=lid)
    l=[]
    for i in bud:
        l.append({'id':i.id,'month':i.Month,'year':i.Year,'budget':i.Budget})
    return JsonResponse({'status':'ok','data':l})


def user_delete_budget(request):
    id=request.POST['id']
    Budget.objects.get(id=id).delete()
    return JsonResponse({'status':'ok'})


def user_income_details(request):
    lid=request.POST['lid']
    income=request.POST['income']
    sourceofincome=request.POST['sourceofincome']
    date=request.POST['date']

    obj=Income()
    obj.USER=Users.objects.get(LOGIN=lid)
    obj.Income=income
    obj.Sourceofincome=sourceofincome
    obj.Date=date
    obj.save()
    return JsonResponse({'status':'ok'})

def receive_tax(request):
    return JsonResponse({'status':'ok'})

def manage_tax(request):
    lid = request.POST['lid']
    taxname = request.POST['taxname']
    taxamount = request.POST['taxamount']
    date=request.POST['date']

    obj = Tax()
    obj.USER = Users.objects.get(LOGIN=lid)
    obj.Tax_name = taxname
    obj.Tax_amount = taxamount
    obj.Date=date
    obj.save()
    return JsonResponse({'status':'ok'})

def notificatons(request):
    lid=request.POST['lid']
    n=Notification.objects.filter(USER__LOGIN__id=lid)
    l = []
    for i in n:
        l.append({'id': i.id, 'date': i.Date, "Notifications": i.Notification})
    return JsonResponse({'status':'ok','data':l})

def suggestions(request):
    lid=request.POST['lid']
    sug=ExpertRequest.objects.filter(USER__LOGIN=lid)
    l=[]
    for i in sug:
        l.append({'id':i.id,'date':i.date,"suggestion":i.reply,'msg':i.Enquiries,"expert":i.EXPERT.Expertname})
    return JsonResponse({'status':'ok','data':l})

def review(request):
    return JsonResponse({'status':'ok'})


from django.db.models import Sum
from django.http import JsonResponse


from django.db.models import Sum
from django.http import JsonResponse

def user_view_expense(request):
    lid = request.POST['lid']

    # Get all expenses for the user
    expenses = Expenses.objects.filter(USER__LOGIN_id=lid)

    # Create a list to hold the total expenses and the budget by year and month
    l = []

    # Loop through distinct year and month values
    distinct_years_months = expenses.values('Year', 'Month').distinct()

    for year_month in distinct_years_months:
        year = year_month['Year']
        month = year_month['Month']

        # Calculate total expenses for this year and month
        total_expenses = expenses.filter(Year=year, Month=month).aggregate(total_expense=Sum('Expenses'))

        # Get the budget for this year and month (using the first expense entry for budget)
        budget_for_period = expenses.filter(Year=year, Month=month).first().BUDGET.Budget

        # Loop through expenses for this year and month
        for expense in expenses.filter(Year=year, Month=month):
            # Store the data for graphing, including expense details
            l.append({
                'id': expense.id,  # Accessing the 'Expenses' field for each expense record
                'expense': expense.Expenses,  # Accessing the 'Expenses' field for each expense record
                'date': expense.Date,         # Accessing the 'Date' field for each expense record
                'description': expense.Discription,  # Accessing the 'Discription' field
                'type': expense.Type,         # Accessing the 'Type' field for each expense record
                'total_expenses': total_expenses['total_expense'] or 0,  # Default to 0 if no expenses
                'budget': budget_for_period,
            })

    # Return the data as JSON for graphing purposes
    return JsonResponse({'status': 'ok', 'data': l})



# def user_view_expense(request):
#     lid=request.POST['lid']
#
#     # di_date = Expenses.objects.filter(USER__LOGIN_id=lid).values_list('date', flat=True).distinct()
#     # di_year = Expenses.objects.filter(USER__LOGIN_id=lid).values_list('year', flat=True).distinct()
#     # di_month = Expenses.objects.filter(USER__LOGIN_id=lid).values_list('month', flat=True).distinct()
#     #
#     # print("Distinct Dates:", list(di_date))
#     # print("Distinct Years:", list(di_year))
#     # print("Distinct Months:", list(di_month))
#     #
#     ex=Expenses.objects.filter(USER__LOGIN_id=lid)
#
#
#
#
#     l=[]
#     for i in ex:
#         l.append({'id':i.id,'date':i.Date,'budget':i.BUDGET.Budget,'expense':i.Expenses,'discription':i.Discription,'category':i.Type})
#     return JsonResponse({'status':'ok','data':l})


def user_delete_expense(request):
    id=request.POST['id']
    Expenses.objects.filter(id=id).delete()
    return JsonResponse({'status':'ok'})


def user_view_income(request):
    lid=request.POST['lid']
    inc=Income.objects.filter(USER__LOGIN_id=lid)
    l=[]
    for i in inc:
        l.append({'id':i.id,'date':i.Date,'income':i.Income,'sourceofincome':i.Sourceofincome})
    print (l)
    return JsonResponse({'status':'ok','data':l})

def user_delete_income(request):
    id=request.POST['id']
    Income.objects.get(id=id).delete()
    return JsonResponse({'status':'ok'})

def user_view_tax(request):
    lid=request.POST['lid']
    tax=Tax.objects.filter(USER__LOGIN_id=lid)
    l=[]
    for i in tax:
        l.append({'id':i.id,'date':i.Date,'taxname':i.Tax_name,'taxamount':i.Tax_amount})
    print (l,)
    return JsonResponse({'status':'ok','data':l})

def user_delete_tax(request):
    id=request.POST['id']
    Tax.objects.get(id=id).delete()
    return JsonResponse({'status':'ok'})

def manage_notifications(request):
    lid = request.POST['lid']
    notify = request.POST['notify']
    date=request.POST['date']

    obj = Notification()
    obj.USER = Users.objects.get(LOGIN=lid)
    obj.Notification = notify

    obj.Date = date
    obj.save()
    return JsonResponse({'status': 'ok'})

def user_view_notification(request):
    lid=request.POST['lid']
    note=Notification.objects.filter(USER__LOGIN_id=lid)
    l=[]
    for i in note:
        l.append({'id':i.id,'date':i.Date,'notification':i.Notification})

    return JsonResponse({'status':'ok','data':l})

def user_delete_notification(request):
    id=request.POST['id']
    Notification.objects.get(id=id).delete()
    return JsonResponse({'status':'ok'})

def view_expert(request):
    expert=Expert.objects.filter(Status="approved")
    l=[]
    for i in expert:
        l.append({'id':i.id,'Name':i.Expertname,'Qualification':i.Qualification,'Experiance':i.Experience,'Gender':i.Gender,'Phone':i.Phone,'Email':i.Email,'Place':i.Place,'Photo':i.Photo,'Status':i.Status})

    print(l)
    return JsonResponse({'status':'ok','data':l})

def view_expert_reviews(request):
    lid=request.POST['lid']
    expert=ExpertReview.objects.exclude(USER__LOGIN_id=lid)
    # expert = ExpertReview.objects.exclude(USER__LOGIN__id=lid).exclude(USER__LOGIN__isnull=True)

    # expert=ExpertReview.objects.all()
    l=[]
    for i in expert:
        l.append({'id':i.id,'user':i.USER.name,'review':i.Review,'rating':i.Rating,'date':i.Date,'expert':i.EXPERT.Expertname,'photo':i.USER.Photo})
    print(l)
    return JsonResponse({'status':'ok','data':l})

def send_request(request):
    lid=request.POST['lid']
    eid=request.POST['eid']
    message=request.POST['message']

    print(lid)
    print(eid)

    req=ExpertRequest()
    req.date=datetime.now().date()
    req.USER=Users.objects.get(LOGIN_id=lid)
    req.EXPERT=Expert.objects.get(id=eid)
    req.Status='requested'
    req.Enquiries=message
    req.reply='pending'
    req.save()
    return JsonResponse({'status': 'ok'})


def send_expert_review(request):
    lid=request.POST['lid']
    eid=request.POST['eid']
    Review=request.POST['review']
    Rating=request.POST['rating']

    req=ExpertReview()

    req.Date=datetime.now().date()
    req.USER=Users.objects.get(LOGIN_id=lid)
    req.EXPERT=Expert.objects.get(id=eid)
    req.Review=Review
    req.Rating=Rating
    req.save()
    return JsonResponse({'status': 'ok'})

def enquiries(request):
    data=ExpertRequest.objects.filter(EXPERT__LOGIN_id=request.session['lid'])
    return render(request,'Expert/Enquiries.html',{'data':data})
def enquiries_post(request):
    f=request.POST['textfield']
    t=request.POST['textfield2']
    data=ExpertRequest.objects.filter(date__range=[f,t],EXPERT__LOGIN_id=request.session['lid'])
    return render(request,'Expert/Enquiries.html',{'data':data})

def reply_enquiries_get(request,id):
    return render(request,"Expert/reply_enquiries.html",{"id":id})

def reply_enquiries_post(request):

    reply=request.POST['textarea']
    id=request.POST['id']
    a=ExpertRequest.objects.filter(id=id).update(Status="Replied",reply=reply)

    return HttpResponse("<script>alert('Replied sucessfully');window.location='/myapp/enquiries/'</script>")


def view_user_budget(request,uid):
    bud=Budget.objects.filter(USER__id=uid)
    return render(request,'Expert/userbudgetview.html',{"data":bud})

def view_user_expenses(request,uid):
    exp=Expenses.objects.filter(USER__id=uid)
    return render(request,'Expert/viewuserexpenses.html',{"data":exp})

def view_user_income(request,uid):
    exp=Income.objects.filter(USER__id=uid)
    return render(request,'Expert/view income.html',{"data":exp})


# def income_and_expense(request):
#     lid=request.POST['lid']
#     a=Expenses.objects.filter(USER__LOGIN_id=lid,Date__year=datetime.now().year)
#     b=Income.objects.filter(USER__LOGIN_id=lid,Date__year=datetime.now().year)
#     d=User.objects.get(LOGIN_id=lid).DOB.year
#
#     total_income=0
#
#     for i in b:
#         total_income=total_income+int(i.Income)
#
#     total_expense=0
#     for i in a:
#         total_expense=total_expense+int(i.Expenses)
#
#
#     age=datetime.now().year-d
#     print(age,"ageeeeeeeeeeeeeeee")
#
#     deductable=0
#     for i in a:
#         if i.Type in ['Health Insurance','Homeowner’s Insurance','Car Insurance','Life Insurance','Disability Insurance','Business Insurance','Travel Insurance','Mortgage Insurance','Insurance for Rental Property']:
#             deductable=deductable+int(i.Expenses)
#             print(deductable,"ddddddddddddddddddddd")
#
#
#     tax_rate=0.00001
#
#
#     if age < 60:
#         if total_income<250000:
#             tax_rate=0.0
#         elif total_income<500000:
#             tax_rate=0.05
#         elif total_income < 1000000:
#             tax_rate = 0.20
#         else:
#             tax_rate=0.30
#
#         print(tax_rate,"jjj")
#
#
#
#     elif 60 <= age < 80:
#         if 60 <= age < 80:
#             if total_income < 300000:
#                 tax_rate = 0.0
#             elif total_income < 500000:
#                 tax_rate = 0.05
#             elif total_income < 1000000:
#                 tax_rate = 0.20
#                 print("iiiiiiiiiiiiiiiiiii")
#             else:
#                 tax_rate = 0.30
#
#     else:
#         if age > 80:
#             if total_income < 500000:
#                 tax_rate = 0.0
#             elif total_income < 1000000:
#                 tax_rate = 0.20
#             else:
#                 tax_rate = 0.3
#     print(deductable,"'''''''''''''")
#
#     Tax_Owed =(total_income-deductable)*tax_rate
#     print(Tax_Owed)
#     return JsonResponse({"status":"ok","data":Tax_Owed})

from datetime import datetime
from django.http import JsonResponse
# from .models import Expenses, Income, User



def income_and_expense(request):
    lid = request.POST.get('lid')
    if not lid:
        return JsonResponse({"status": "error", "message": "Missing login ID"}, status=400)

    try:
        user = Users.objects.get(LOGIN_id=lid)
        age = datetime.now().year - user.DOB.year
    except Users.DoesNotExist:
        return JsonResponse({"status": "error", "message": "User not found"}, status=404)

    # Fetching income and expenses for the current year
    current_year = datetime.now().year
    expenses = Expenses.objects.filter(USER__LOGIN_id=lid, Date__year=current_year)
    incomes = Income.objects.filter(USER__LOGIN_id=lid, Date__year=current_year)

    # Calculate total income and total expenses
    total_income = sum(float(i.Income or 0) for i in incomes)
    total_expense = sum(float(i.Expenses or 0) for i in expenses)

    # Deductible expenses categories
    deductible_categories = {
        "Health Insurance", "Homeowner’s Insurance", "Car Insurance",
        "Life Insurance", "Disability Insurance", "Business Insurance",
        "Travel Insurance", "Mortgage Insurance", "Insurance for Rental Property"
    }
    deductible = sum(float(i.Expenses or 0) for i in expenses if i.Type in deductible_categories)

    # Ensure deductible does not exceed total income
    taxable_income = max(0, total_income - deductible)

    # Debugging logs
    print(f"Total Income: {total_income}")
    print(f"Total Expense: {total_expense}")
    print(f"Deductible Amount: {deductible}")
    print(f"Taxable Income: {taxable_income}")

    # Define tax slabs based on age
    if age < 60:
        tax_slabs = [(250000, 0.0), (500000, 0.05), (1000000, 0.20), (float('inf'), 0.30)]
    elif 60 <= age < 80:
        tax_slabs = [(300000, 0.0), (500000, 0.05), (1000000, 0.20), (float('inf'), 0.30)]
    else:  # Age 80+
        tax_slabs = [(500000, 0.0), (1000000, 0.20), (float('inf'), 0.30)]

    # Calculate progressive tax
    tax_owed = 0.0
    prev_limit = 0
    for limit, rate in tax_slabs:
        if taxable_income > prev_limit:
            taxable_at_this_rate = min(limit - prev_limit, taxable_income - prev_limit)
            tax_owed += taxable_at_this_rate * rate
            prev_limit = limit
        else:
            break

    # Debugging log for tax owed
    print(f"Tax Owed: {tax_owed}")

    return JsonResponse({"status": "ok", "tax_owed": round(tax_owed, 2),'total_income':str(total_income),'total_expense':str(total_expense),'deductible':str(deductible),'taxable_income':str(taxable_income)})









from django.db.models import Sum
from datetime import date

def get_monthly_data(request):
    # Get total income for the current month
    total_income = Income.objects.filter(
        Date__month=date.today().month,
        Date__year=date.today().year
    ).aggregate(Sum('Income'))['Income__sum'] or 0

    # Get total expenses for the current month
    total_expenses = Expenses.objects.filter(
        Date__month=date.today().month,
        Date__year=date.today().year
    ).aggregate(Sum('Expenses'))['Expenses__sum'] or 0

    # Return data as JSON response
    return JsonResponse({
        'total_income': total_income,
        'total_expenses': total_expenses
    })
#

def monthly_expense(request):
    lid=request.POST['lid']
    a=Expenses.objects.filter(USER__LOGIN=lid,Type="Food").aggregate(total=sum('expense'))['total']
    b=Expenses.objects.filter(USER__LOGIN=lid,Type="Transport").aggregate(total=sum('expense'))['total']
    c=Expenses.objects.filter(USER__LOGIN=lid,Type="Entertainment").aggregate(total=sum('expense'))['total']
    d=Expenses.objects.filter(USER__LOGIN=lid,Type="Utilities").aggregate(total=sum('expense'))['total']
    e=Expenses.objects.filter(USER__LOGIN=lid,Type="Health Insurance").aggregate(total=sum('expense'))['total']
    f=Expenses.objects.filter(USER__LOGIN=lid,Type="Homeowner’s Insurance").aggregate(total=sum('expense'))['total']
    g=Expenses.objects.filter(USER__LOGIN=lid,Type="Life Insurance").aggregate(total=sum('expense'))['total']
    h=Expenses.objects.filter(USER__LOGIN=lid,Type="Disability Insurance").aggregate(total=sum('expense'))['total']
    i=Expenses.objects.filter(USER__LOGIN=lid,Type="Business Insurance").aggregate(total=sum('expense'))['total']
    j=Expenses.objects.filter(USER__LOGIN=lid,Type="Travel Insurance").aggregate(total=sum('expense'))['total']
    k=Expenses.objects.filter(USER__LOGIN=lid,Type="Mortgage Insurance").aggregate(total=sum('expense'))['total']
    l=Expenses.objects.filter(USER__LOGIN=lid,Type="Insurance for Rental Property").aggregate(total=sum('expense'))['total']

    # Prepare the response data
    response_data = {
        'Food': float(a),
        'Transport': float(b),
        'Entertainment': float(c),
        'Utilities': float(d),
        'Health Insurance': float(e),
        'Homeowner’s Insurance': float(f),
        'Life Insurance': float(g),
        'Disability Insurance': float(h),
        'Business Insurance': float(i),
        'Travel Insurance': float(j),
        'Mortgage Insurance': float(k),
        'Insurance for Rental Property': float(l),
    }

    return JsonResponse(response_data)

#
#
# from django.http import JsonResponse
# from django.db.models import Sum
# from .models import Expenses
#
#
# def monthly_expense(request):
#     lid = request.POST['lid']
#
#     # Calculate total expenses for each category
#     categories = [
#         "Food", "Transport", "Entertainment", "Utilities",
#         "Health Insurance", "Homeowner’s Insurance", "Life Insurance",
#         "Disability Insurance", "Business Insurance", "Travel Insurance",
#         "Mortgage Insurance", "Insurance for Rental Property"
#     ]
#
#     response_data = {}
#     for category in categories:
#         total = Expenses.objects.filter(USER__LOGIN=lid, Type=category).aggregate(total=Sum('expense'))['total']
#         response_data[category] = float(total) if total else 0.0
#
#     return JsonResponse(response_data)



# from django.http import JsonResponse
# from django.db.models import Sum
# from .models import Expenses
#
#
# def monthly_expense(request):
#     # Get the logged-in user's ID from the request
#     lid = request.POST['lid']
#
#     # Calculate total expenses for each category
#     categories = [
#         "Food", "Transport", "Entertainment", "Utilities", "Health Insurance",
#         "Homeowner’s Insurance", "Life Insurance", "Disability Insurance",
#         "Business Insurance", "Travel Insurance", "Mortgage Insurance",
#         "Insurance for Rental Property"
#     ]
#
#     response_data = {}
#
#     # Loop over all categories and sum the expenses
#     for category in categories:
#         total_expense = Expenses.objects.filter(USER__LOGIN=lid, Type=category).aggregate(total=Sum('expense'))[
#                             'total'] or 0.0
#         response_data[category] = float(total_expense)
#
#     return JsonResponse(response_data)




from django.shortcuts import render
from django.http import JsonResponse
from .models import Expenses
from django.db.models import Sum


def advice_to_user_post(request):
    user_id = request.POST['lid']
    try:
        # Sum the total expenses for the user in the current month (or all time)
        total_expenses = Expenses.objects.filter(
            USER__LOGIN_id=user_id,
            Month=datetime.now().month,
            Year=datetime.now().year
        )

        sm=0

        for i in total_expenses:
            sm= sm+ float(i.Expenses)

        print(sm,"hhhh")

        total_expenses=sm
        if total_expenses ==0:
            return JsonResponse({'advice': 'No expenses found for this user.'})
        if total_expenses < 20000:
            advice = "You are in the low-income tax bracket. Take advantage of tax-saving schemes like 401(k)."
        elif total_expenses < 50000:
            advice = "You're in the middle-income tax bracket. Consider maximizing tax deductions for retirement savings."
        elif total_expenses < 100000:
            advice = "You're in a higher tax bracket. Explore tax planning strategies like investing in tax-efficient funds."
        else:
            advice = "You're in the highest tax bracket. Work with a tax advisor to optimize your tax strategies."
        return JsonResponse({'advice': advice, 'total_expenses': total_expenses})
    except Expenses.DoesNotExist:
        return JsonResponse({'advice': 'User or expenses not found.'})


# views.py


from django.shortcuts import render
from django.http import JsonResponse
from django.db.models import Sum
from .models import Income, Expenses
from django.contrib.auth.models import User


def get_investment_advice(request):
    lid=request.POST['lid']
    try:
        total_income = Income.objects.filter(USER_id=lid).aggregate(Sum('Income'))['Income__sum'] or 0

        total_expenses = Expenses.objects.filter(USER_id=lid).aggregate(Sum('Expenses'))['Expenses__sum'] or 0

        income_expense_diff = total_income - total_expenses

        if income_expense_diff < 500:
            advice = "You should consider conservative investments, like bonds or savings accounts."
        elif 500 <= income_expense_diff <= 5000:
            advice = "A balanced approach, such as mutual funds or index funds, would suit your financial situation."
        else:
            advice = "You have room for aggressive investments like stocks or re              al estate. Consider diversifying your portfolio."

        return JsonResponse({'status': 'ok', 'advice': advice})

    except User.DoesNotExist:
        return JsonResponse({'status': 'error', 'message': 'User not found'})

    except Exception as e:
        return JsonResponse({'status': 'error', 'message': str(e)})


from django.views.decorators.csrf import csrf_exempt
import json
import google.generativeai as genai

# Configure Gemini
GOOGLE_API_KEY = 'AIzaSyBYkYwn8IdHQm3S4-FrzBTXL9Tv_zSRDiw'  # Replace with your actual API key
genai.configure(api_key=GOOGLE_API_KEY)
model = genai.GenerativeModel('gemini-1.5-flash')

# Map month names to their corresponding integer values
MONTH_MAP = {
    'January': 1, 'February': 2, 'March': 3, 'April': 4,
    'May': 5, 'June': 6, 'July': 7, 'August': 8,
    'September': 9, 'October': 10, 'November': 11, 'December': 12
}
@csrf_exempt
def generate_financial_report(request):

    # Parse the request body
    user_id = request.POST['lid']
    month_name = request.POST['month']
    year = request.POST['year']


    print(user_id)
    print(month_name)
    print(year)


    if not user_id or not month_name or not year:
        return JsonResponse({'error': 'Missing required fields'}, status=400)

    # Convert year to integer
    try:
        year = int(year)
    except ValueError:
        return JsonResponse({'error': 'Invalid year'}, status=400)

        # Convert month name to integer
    month = MONTH_MAP.get(month_name)


    if not month:
        return JsonResponse({'error': 'Invalid month name'}, status=400)

    # Fetch budget data for the given user, month, and year
    try:
        # Use the month name directly (e.g., 'March')
        print(month_name,"helllo2",year)
        budget = Budget.objects.get(USER__LOGIN_id=user_id, Month=month_name, Year=year)
    except Budget.DoesNotExist:
        print("no2")
        return JsonResponse({'message': 'No data available for the specified month and year'}, status=404)
    print("hello")

    ms=["January","February","March","April","May","June","July","August","September","October","November","December"]


    # Fetch income for the given user, month, and year
    incomes = Income.objects.filter(USER__LOGIN_id=user_id, Date__year=year, Date__month=ms.index(month_name)+1)
    print(incomes,'income')
    # Fetch expenses for the given user, month, and year
    expenses = Expenses.objects.filter(USER__LOGIN_id=user_id, Month=month, Year=year)
    print(expenses,'exp')
    # Calculate total income and expenses
    total_income = sum(float(income.Income) for income in incomes)
    total_expenses = sum(float(expense.Expenses) for expense in expenses)
    print(total_income,'t inc')
    print(total_expenses,'t exp')
    # Prepare financial data
    financial_data = {
        'total_budget': float(budget.Budget),
        'total_expenses': total_expenses,
        'total_income': total_income,
        'savings': total_income - total_expenses,
        'month': month_name,
        'year': year,
    }

    print(financial_data)

    # Generate a detailed financial report using Gemini
    # prompt = f"""
    # Analyze the following financial data for {month_name} {year} and provide a detailed financial report:
    # - Total Budget: {financial_data['total_budget']}
    # - Total Expenses: {financial_data['total_expenses']}
    # - Total Income: {financial_data['total_income']}
    # - Savings: {financial_data['savings']}
    #
    # Provide insights into spending habits, areas where the user can save more, and suggestions for better financial planning.
    # """

    prompt = f"""
        Analyze the following financial data for {month_name} {year} and provide a detailed financial report in Indian Rupees (₹):
        - Total Budget: ₹{financial_data['total_budget']}
        - Total Expenses: ₹{financial_data['total_expenses']}
        - Total Income: ₹{financial_data['total_income']}
        - Savings: ₹{financial_data['savings']}

        Provide insights into spending habits, areas where the user can save more, and suggestions for better financial planning.
        """

    gemini_response = model.generate_content(prompt)

    # Combine raw data and Gemini's analysis
    financial_report = {
        'raw_data': financial_data,
        'analysis': gemini_response.text,
    }

    return JsonResponse({'financial_report': financial_report})


######################


#
#
#
# def monthly_expense_graph(request):
#     try:
#         lid = request.POST.get('lid')  # User ID
#         year = request.POST.get('year')  # Selected year
#         month = request.POST.get('month')  # Selected month
#
#         # Fetch expenses for the selected month and year
#         expenses = Expenses.objects.filter(
#             USER__LOGIN=lid,
#             Month=month,
#             Year=year
#         ).values('Type').annotate(total=Sum('Expenses'))
#
#         # Prepare data for the graph
#         expense_data = {item['Type']: float(item['total']) for item in expenses}
#
#         return JsonResponse(expense_data)
#     except Exception as e:
#         return JsonResponse({'error': str(e)}, status=500)
#
# from django.db.models import Sum
# from datetime import datetime
# from django.http import JsonResponse
# from .models import Income, Expenses, Budget, ExpertReview
# import calendar
#
# def dashboard_summary(request):
#     try:
#         lid = request.POST.get('lid')  # User ID
#         current_month_num = datetime.now().month  # Get the current month as an integer
#         current_year = str(datetime.now().year)  # Get the current year as a string
#
#         # Convert numeric month (e.g., 3) to month name (e.g., "March")
#         current_month_name = calendar.month_name[current_month_num]  # "March", "April", etc.
#
#         # Debugging: Print the values being used in the query
#         print(f"User ID: {lid}, Month: {current_month_name}, Year: {current_year}")
#
#         # Fetch total income for the current month
#         income_query = Income.objects.filter(
#             USER__LOGIN_id=lid,
#             Date__month=current_month_num,  # Filter by month
#             Date__year=int(current_year)  # Filter by year
#         )
#         total_income = income_query.aggregate(total=Sum('Income'))['total'] or 0
#
#         # Debugging: Print income query and results
#         print("Income Query:", income_query.query)
#         print("Income Data:", list(income_query.values()))
#         print("Total Income:", total_income)
#
#         # Fetch total expenses for the current month and year
#         expenses_query = Expenses.objects.filter(
#             USER__LOGIN=lid,
#             Month=current_month_num,  # Use the full month name here
#             Year=current_year  # Use the year as a string
#         )
#         total_expenses = expenses_query.aggregate(total=Sum('Expenses'))['total'] or 0
#
#         # Debugging: Print expenses query and results
#         print("Expenses Query:", expenses_query.query)
#         print("Expenses Data:", list(expenses_query.values()))
#         print("Total Expenses:", total_expenses)
#
#         # Check if no expenses are found
#         if total_expenses == 0:
#             print(f"No expenses found for User ID: {lid} for {current_month_name} {current_year}")
#
#         # Fetch total budget for the current month and year
#         budget_query = Budget.objects.filter(
#             USER__LOGIN_id=lid,  # Match User ID
#             Month=current_month_name,  # Match the full month name
#             Year=current_year  # Match Year
#         )
#         total_budget = budget_query.aggregate(total=Sum('Budget'))['total'] or 0
#
#         # Debugging: Print budget query and results
#         print("Budget Query:", budget_query.query)
#         print("Budget Data:", list(budget_query.values()))
#         print("Total Budget:", total_budget)
#
#         # Check if no budget is available for the current date
#         if not budget_query.exists():
#             print("No budget set for the current month and year.")
#             total_budget = 0  # You can set this to a default value if needed
#
#         # Fetch Expert Reviews for the current month and year (optional)
#
#
#
#         # Return the result as JSON
#         return JsonResponse({
#             'total_income': float(total_income),
#             'total_expenses': float(total_expenses),
#             'total_budget': float(total_budget),
#         })
#
#     except Exception as e:
#         # Log or print the exception for debugging purposes
#         print(f"Error: {str(e)}")
#         return JsonResponse({'error': str(e)}, status=500)
#

from django.db.models import Sum
from datetime import datetime
from django.http import JsonResponse
from .models import Income, Expenses, Budget
import calendar

def dashboard_summary(request):
    try:
        lid = request.POST.get('lid')  # User ID
        month = request.POST.get('month')  # Optional: Selected month
        year = request.POST.get('year')  # Optional: Selected year

        # If no specific month and year are given, fetch all past data (including 2024)
        if not month or not year:
            print("Fetching all past data up to the current date...")
            income_query = Income.objects.filter(USER__LOGIN_id=lid)
            expenses_query = Expenses.objects.filter(USER__LOGIN=lid)
            budget_query = Budget.objects.filter(USER__LOGIN_id=lid)
        else:
            month = int(month)
            year = int(year)
            month_name = calendar.month_name[month]  # Convert month number to name

            print(f"User ID: {lid}, Month: {month_name}, Year: {year}")

            # Fetch total income for the selected month and year
            income_query = Income.objects.filter(
                USER__LOGIN_id=lid,
                Date__month=month,
                Date__year=year
            )

            # Fetch total expenses for the selected month and year
            expenses_query = Expenses.objects.filter(
                USER__LOGIN=lid,
                Month=month,
                Year=year
            )

            # Fetch total budget for the selected month and year
            budget_query = Budget.objects.filter(
                USER__LOGIN_id=lid,
                Month=month_name,
                Year=year
            )

        # Aggregating total amounts
        total_income = income_query.aggregate(total=Sum('Income'))['total'] or 0
        total_expenses = expenses_query.aggregate(total=Sum('Expenses'))['total'] or 0
        total_budget = budget_query.aggregate(total=Sum('Budget'))['total'] or 0

        # Debugging Logs
        print("Income Data:", list(income_query.values()))
        print("Total Income:", total_income)
        print("Expenses Data:", list(expenses_query.values()))
        print("Total Expenses:", total_expenses)
        print("Budget Data:", list(budget_query.values()))
        print("Total Budget:", total_budget)

        if total_expenses == 0:
            print(f"No expenses found for User ID: {lid} for {month_name} {year}")

        if not budget_query.exists():
            print(f"No budget set for {month_name} {year}.")
            total_budget = 0

        return JsonResponse({
            'total_income': float(total_income),
            'total_expenses': float(total_expenses),
            'total_budget': float(total_budget),
        })

    except Exception as e:
        print(f"Error: {str(e)}")
        return JsonResponse({'error': str(e)}, status=500)
000000


from django.db.models import Sum
from django.http import JsonResponse
from .models import Expenses

def monthly_expense_graph(request):
    try:
        lid = request.POST.get('lid')  # User ID
        year = request.POST.get('year')  # Selected year
        month = request.POST.get('month')  # Selected month

        # Fetch expenses for the selected month and year
        expenses = Expenses.objects.filter(
            USER__LOGIN=lid,
            Month=month,
            Year=year
        ).values('Type').annotate(total=Sum('Expenses'))

        # Prepare data for the graph
        expense_data = {item['Type']: float(item['total']) for item in expenses}

        return JsonResponse(expense_data)
    except Exception as e:
        return JsonResponse({'error': str(e)}, status=500)

def send_complaint(request):
    lid = request.POST['lid']
    com = request.POST['com']

    req = complaint()

    req.Date = datetime.now().date()
    req.USER = Users.objects.get(LOGIN_id=lid)
    req.Complaint = com
    req.Reply = 'pending'
    req.Status = 'pending'
    req.Complaint = com
    req.save()
    return JsonResponse({'status': 'ok'})


def view_replay(request):

    lid=request.POST['lid']
    C=complaint.objects.filter(USER__LOGIN_id=lid)

    l=[]
    for i in C:
        l.append({'id':i.id,'Complaint':i.Complaint,'Status':i.Status,'Reply':i.Reply,'Date':i.Date})
    print(l)
    return JsonResponse({'status':'ok','data':l})
