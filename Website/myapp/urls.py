"""PFM URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path

from myapp import views
urlpatterns = [


    path('admin_home/',views.admin_home),

    path('login_get/',views.login_get),
    path('login_post/',views.login_post),

    path('add_expert_get/',views.add_expert_get),
    path('add_expert_post/',views.add_expert_post),

    path('edit_expert_get/<id>', views.edit_expert_get),
    path('edit_expert_post/', views.edit_expert_post),

    path('Admin_expert_views_get/', views.Admin_expert_views_get),
    path('Admin_expert_views_post/', views.Admin_expert_views_post),

    path('admin_delete_expert/<id>', views.admin_delete_expert),

    path('add_user_get/',views.add_user_get),
    path('add_user_post/',views.add_user_post),

    path('edit_user_get/<id>',views.edit_user_get),
    path('edit_user_post/',views.edit_user_post),

    path('AdminUserViews_get/',views.AdminUserViews_get),
    path('AdminUserViews_post/',views.AdminUserViews_post),

    path('admin_delete_user/<id>', views.admin_delete_user),

    path('AdminViewsComplain_get/',views.AdminViewComplain_get),
    path('AdminViewsComplain_post/',views.AdminViewComplain_post),

    path('ChangePassword_get/',views.ChangePassword_get),
    path('ChangePassword_post/',views.ChangePassword_post),

    path('SendReply_get/<id>',views.SendReply_get),
    path('SendReply_post/',views.SendReply_post),

    path('Admin_view_approved_expert_get/',views.Admin_view_approved_expert_get),
    path('Admin_view_rejected_expert_get/',views.Admin_view_rejected_expert_get),

    path('Approve_expert/<id>',views.Approve_expert),
    path('Reject_expert/<id>',views.Reject_expert),

    path('Admin_view_approved_expert_post/',views.Admin_view_approved_expert_post),
    path('Admin_view_rejected_expert_post/',views.Admin_view_rejected_expert_post),

    path('expert_home/',views.expert_home),


    path('expert_signup/',views.expert_signup),
    path('expert_signup_post/',views.expert_signup_post),

    path('expert_home/',views.expert_home),

    path('send_suggestion/',views.send_suggestion),
    path('send_suggestion_Post/',views.send_suggestion_Post),

    path('Expert_ChangePassword_get/',views.Expert_ChangePassword_get),
    path('Expert_ChangePassword_post/',views.Expert_ChangePassword_post),

    path('Expert_view_profile/',views.Expert_view_profile),


    path('Expert_Edit_profile_get/',views.Expert_Edit_profile),
    path('Expert_Edit_profile_post/', views.Expert_Edit_profile_post),



    #############
    path('user_login_post/',views.user_login_post),
    path('user_signup/',views.user_signup),
    path('user_change_password/',views.user_change_password),
    path('user_profile/',views.user_profile),
    path('user_edit_profile/',views.user_edit_profile),
    path('user_expenses/',views.user_expenses),
    path('user_budget_manage/',views.user_budget_manage),
    path('user_income_details/',views.user_income_details),
    path('receive_tax/',views.receive_tax),
    path('manage_tax/',views.manage_tax),
    path('notificatons/',views.notificatons),
    path('suggestions/',views.suggestions),
    path('review/',views.review),
    path('user_change_password/',views.user_change_password),
    path('user_view_budget/',views.user_view_budget),
    path('user_delete_budget/',views.user_delete_budget),
    path('user_view_expense/',views.user_view_expense),
    path('user_delete_expense/',views.user_delete_expense),
    path('user_view_income/',views.user_view_income),
    path('user_delete_income/',views.user_delete_income),
    path('user_view_tax/',views.user_view_tax),
    path('user_delete_tax/',views.user_delete_tax),
    path('manage_notifications/',views.manage_notifications),
    path('user_view_notification/',views.user_view_notification),
    path('user_delete_notification/',views.user_delete_notification),
    path('view_expert/',views.view_expert),
    path('send_request/',views.send_request),
    path('send_expert_review/',views.send_expert_review),
    path('view_expert_reviews/',views.view_expert_reviews),
    path('enquiries/',views.enquiries),
    path('enquiries_post/',views.enquiries_post),

    path('reply_enquiries_get/<id>',views.reply_enquiries_get),
    path('reply_enquiries_post/',views.reply_enquiries_post),
    path('view_user_budget/<uid>',views.view_user_budget),
    path('view_user_expenses/<uid>',views.view_user_expenses),
    path('view_user_income/<uid>',views.view_user_income),
    path('income_and_expense/',views.income_and_expense),
    path('get_monthly_data/',views.get_monthly_data),
    path('monthly_expense/',views.monthly_expense),
    path('advice_to_user_post/',views.advice_to_user_post),
    path('get_investment_advice/',views.get_investment_advice),


    path('monthly_expense_graph/',views.monthly_expense_graph),
    path('send_complaint/',views.send_complaint),
    path('view_replay/',views.view_replay),
    path('dashboard_summary/',views.dashboard_summary),

    path('generate_financial_report/', views.generate_financial_report),










]