<#include "security.ftl">
<#import "login.ftl" as l>

<!-- Main Sidebar Container -->
<aside class="main-sidebar sidebar-dark-primary elevation-4">
    <a href="/" class="brand-link">
       <!-- <img src="dist/img/AdminLTELogo.png" alt="AdminLTE Logo" class="brand-image img-circle elevation-3" style="opacity: .8">-->
        <span class="brand-text font-weight-light">Corp Portal</span>
    </a>
    <div class="sidebar">
        <!-- Sidebar user panel (optional) -->
        <div class="user-panel mt-3 pb-3 mb-3 d-flex">
            <!--<div class="image">
                <img src="dist/img/user2-160x160.jpg" class="img-circle elevation-2" alt="User Image">
            </div>-->
            <div class="image">
                <img src="../static/img/avatarIcon.png" class="img-circle elevation-2" alt="User Image">
            </div>
            <div class="info">
                <#if user??>
                     <a href="/user/profile" class="d-block">${firstname} ${surname} </a>
                </#if>
            </div>
            <div class="info">
                <@l.logout />
            </div>
        </div>
        <nav class="mt-2">
            <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
                <#if isAdmin>
                <li class="nav-item">
                    <a href="#" class="nav-link">
                        <i class="fas fa-user-cog nav-icon"></i>
                        <p>
                            Администратор
                            <i class="fas fa-angle-left right"></i>
                        </p>
                    </a>
                    <ul class="nav nav-treeview">
                        <li class="nav-item">
                            <a href="/config" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Настройки</p>
                            </a>
                        </li>
                    </ul>
                    <ul class="nav nav-treeview">
                        <li class="nav-item">
                            <a href="/user" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Пользователи</p>
                            </a>
                        </li>
                    </ul>
                </li>
                </#if>
                <li class="nav-item">
                    <a href="#" class="nav-link">
                        <i class="nav-icon fas fa-copy"></i>
                        <p>
                            Мои задачи
                            <i class="fas fa-angle-left right"></i>
                            <span class="badge badge-info right">6</span>
                        </p>
                    </a>
                    <ul class="nav nav-treeview">
                        <li class="nav-item">
                            <a href="/config" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Входящие</p>
                            </a>
                        </li>
                    </ul>
                    <ul class="nav nav-treeview">
                        <li class="nav-item">
                            <a href="/user" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Исходящие</p>
                            </a>
                        </li>
                    </ul>
                </li>
                <li class="nav-item">
                    <a href="/project" class="nav-link">
                        <i class="nav-icon far fa-image"></i>
                        <p>
                            Проекты
                        </p>
                    </a>
                </li>
            </ul>
        </nav>
    </div>
</aside>