<!DOCTYPE html>
<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html lang="en">

    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Star Admin Free Bootstrap Admin Dashboard Template</title>
        <!-- plugins:css -->
        <link rel="stylesheet" href="vendors/iconfonts/mdi/css/materialdesignicons.min.css">
        <link rel="stylesheet" href="vendors/css/vendor.bundle.base.css">
        <link rel="stylesheet" href="vendors/css/vendor.bundle.addons.css">
        <!-- endinject -->
        <!-- plugin css for this page -->
        <!-- End plugin css for this page -->
        <!-- inject:css -->
        <link rel="stylesheet" href="css/style.css">
        <!-- endinject -->
        <link rel="shortcut icon" href="images/favicon.png" />
    </head>

    <body>
        <%

            String pages = request.getParameter("page");
            String category = request.getParameter("category");
            String search = request.getParameter("search");
            String query, count_query = "";
            try {
                if (search.isEmpty()) {
                    search = "1=1";
                    query = "select * from arkenadvertisement where status='ACT' and ( ? ) limit ?,10";
                    count_query = "select count(*) as ad_count_all from arkenadvertisement where status='ACT'";
                } else {
//                search= "ad_subject like '%"+search+"%' or ad_content like '%"+search+"%'";
                    search = "%" + search + "%";
                    query = "select * from arkenadvertisement where status='ACT' and (ad_content like ? or ad_subject like '" + search + "' ) limit ?,10";
                    count_query = "select count(*) as ad_count_all from arkenadvertisement where status='ACT' and (ad_content like '" + search + "' or ad_subject like '" + search + "' )";
                }
            } catch (Exception e) {
                e.printStackTrace();
                search = "1=1";
                query = "select * from arkenadvertisement where status='ACT' and ( ? ) limit ?,10";
                count_query = "select count(*) as ad_count_all from arkenadvertisement where status='ACT'";
            }
            System.out.print(search);
        %>

        <c:set var = "salary" scope = "session" value = "${2000*2}"/>
        <c:set var = "c_page" value="<%= pages%>" />  
        <c:set var = "c_category"  value="<%= category%>"  />   
        <c:set var = "c_search"  value="<%= search%>"  />   
        <c:set var = "query"  value="<%= query%>"  />   
        <c:set var = "count_query"  value="<%= count_query%>"  />   

        <c:set var = "from_p" scope = "session" value = "${c_page*10}"/>
        <fmt:parseNumber var="i" type="number" value="${from_p}" />
        <sql:setDataSource var = "snapshot" driver = "com.mysql.jdbc.Driver" url = "jdbc:mysql://localhost:3306/mart"  user = "root"  password = "password"/>
        <sql:query dataSource = "${snapshot}" var = "result">
            ${query}
            <c:choose>
                <c:when test="${i lt 0}">
                    <fmt:parseNumber var="i" type="number" value="0" />
                    <sql:param  value="${c_search}" />
                    <sql:param  value="${i}" />
                </c:when>
                <c:when test="${i lt 1}">
                    <c:set var="fpage" value="false"/>
                    <sql:param  value="${c_search}" />
                    <sql:param  value="${i}" />
                </c:when>
                <c:otherwise>
                    <c:set var="fpage" value="true"/>
                    <sql:param  value="${c_search}" />
                    <sql:param  value="${i}" />
                </c:otherwise>
            </c:choose>
        </sql:query>
        <sql:query dataSource = "${snapshot}" var = "ad_count_result">
            select count(ad_category) as ad_count,ad_category from arkenadvertisement where status='ACT' group by ad_category;
        </sql:query>  
        <sql:query dataSource = "${snapshot}" var = "ad_count_all_result">
            ${count_query}
        </sql:query>      

        <div class="container-scroller">
            <!-- partial:partials/_navbar.html -->
            <nav class="navbar default-layout col-lg-12 col-12 p-0 fixed-top d-flex flex-row">
                <div class="text-center navbar-brand-wrapper d-flex align-items-top justify-content-center">
                    <!--        <a class="navbar-brand brand-logo" href="index.jsp">
                              <img src="images/logo.png" alt="logo" />
                            </a>-->

                    <div class="text-wrapper">  
                        <div> 
                            <span class="status-indicator online"></span>
                        </div>
                    </div>
                    <a class="navbar-brand brand-logo-mini" href="index.jsp">
                        <img src="images/logo-mini.svg" alt="logo" />
                    </a>
                </div>
                <div class="navbar-menu-wrapper d-flex align-items-center">

                    <ul class="navbar-nav navbar-nav-right">


                        <li class="nav-item dropdown d-none d-xl-inline-block">
                            <a class="nav-link dropdown-toggle" id="UserDropdown" href="#" data-toggle="dropdown" aria-expanded="false">
                                <span class="profile-text">Hello, Richard V.Welsh !</span>

                            </a>
                            <div class="dropdown-menu dropdown-menu-right navbar-dropdown" aria-labelledby="UserDropdown"> 
                                <a class="dropdown-item mt-2">
                                    Manage Posts
                                </a> 
                                <a class="dropdown-item">
                                    Sign Out
                                </a>
                            </div>
                        </li>
                    </ul>
                    <button class="navbar-toggler navbar-toggler-right d-lg-none align-self-center" type="button" data-toggle="offcanvas">
                        <span class="mdi mdi-menu"></span>
                    </button>
                </div>
            </nav>
            <!-- partial -->
            <div class="container-fluid page-body-wrapper">
                <!-- partial:partials/_sidebar.html -->
                <nav class="sidebar sidebar-offcanvas" id="sidebar">
                    <ul class="nav">
                        <li class="nav-item nav-profile">
                            <div class="nav-link">
                                <div class="user-wrapper">


                                </div>

                            </div>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="index.jsp"> 
                                <i class="menu-icon mdi mdi-car"></i>
                                <span class="menu-title">Vehicles</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" data-toggle="collapse" href="#ui-basic" aria-expanded="false" aria-controls="ui-basic">
                                <i class="menu-icon mdi mdi-television"></i>
                                <span class="menu-title">Electronics</span>
                                <i class="menu-arrow"></i>
                            </a>
                            <div class="collapse" id="ui-basic">
                                <ul class="nav flex-column sub-menu">
                                    <li class="nav-item">
                                        <a class="nav-link" href="pages/ui-features/buttons.html">Mobile</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" href="pages/ui-features/typography.html">DeskTop</a>
                                    </li>
                                </ul>
                            </div>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="pages/forms/basic_elements.html">
                                <i class="menu-icon mdi mdi-tie"></i>
                                <span class="menu-title">Jobs</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="pages/charts/chartjs.html">
                                <i class="menu-icon mdi mdi-home"></i>
                                <span class="menu-title">Real Estate</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="pages/tables/basic-table.html">
                                <i class="menu-icon mdi mdi-chart-line"></i>
                                <span class="menu-title">Business</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="pages/icons/font-awesome.html">
                                <i class="menu-icon mdi mdi-library"></i>
                                <span class="menu-title">Educations</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="pages/icons/font-awesome.html">
                                <i class="menu-icon mdi mdi-account-circle"></i>
                                <span class="menu-title">Personal</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="pages/icons/font-awesome.html">
                                <i class="menu-icon mdi mdi-shopping"></i>
                                <span class="menu-title">Other</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" data-toggle="collapse" href="#auth" aria-expanded="false" aria-controls="auth">
                                <i class="menu-icon mdi mdi-restart"></i>
                                <span class="menu-title">Testing links</span>
                                <i class="menu-arrow"></i>
                            </a>
                            <div class="collapse" id="auth">
                                <ul class="nav flex-column sub-menu">
                                    <li class="nav-item">
                                        <a class="nav-link" href="pages/samples/blank-page.html"> Blank Page </a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" href="pages/samples/login.html"> Login </a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" href="pages/samples/register.html"> Register </a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" href="pages/samples/error-404.html"> 404 </a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" href="pages/samples/error-500.html"> 500 </a>
                                    </li>
                                </ul>
                            </div>
                        </li>
                    </ul>
                </nav>
                <!-- partial -->
                <div class="main-panel">
                    <div class="content-wrapper">
                        <div class="row purchace-popup">

                        </div>

                        <div class="row">

                            <div class="col-10 grid-margin">
                                <div class="card">
                                    <div class="card-body">
                                        <h5 class="card-title mb-4">Manage Tickets</h5>
                                        <div class="fluid-container">
                                            <c:forEach var = "row" items = "${result.rows}">
                                            <div class="row ticket-card mt-3 pb-2 border-bottom pb-3 mb-3">
                                                <div class="col-md-2">
                                                    <a href="pages/samples/blank-page.html"><img class="img-thumbnail" height="100" width="100" src="images/faces/face1.jpg" alt="profile image"></a>
                                                </div>
                                                <div class="ticket-details col-md-9">
                                                    <div class="d-flex">
                                                        <p class="text-dark font-weight-semibold mr-2 mb-0 no-wrap">James :</p>
                                                        <p class="text-primary mr-1 mb-0">[#23047]</p>
                                                        <p class="mb-0 ellipsis">Donec rutrum congue leo eget malesuada.</p>
                                                    </div>
                                                    <p class="text-gray ellipsis mb-2">Donec rutrum congue leo eget malesuada. Quisque velit nisi, pretium ut lacinia in, elementum id enim
                                                        vivamus.
                                                    </p>
                                                    <div class="row text-gray d-md-flex d-none">
                                                        <div class="col-4 d-flex">
                                                            <small class="mb-0 mr-2 text-muted text-muted">Last responded :</small>
                                                            <small class="Last-responded mr-2 mb-0 text-muted text-muted">3 hours ago</small>
                                                        </div>
                                                        <div class="col-4 d-flex">
                                                            <small class="mb-0 mr-2 text-muted text-muted">Due in :</small>
                                                            <small class="Last-responded mr-2 mb-0 text-muted text-muted">2 Days</small>
                                                        </div>
                                                    </div>
                                                </div>

                                            </div>
                                            
                                            </c:forEach>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <c:forEach var = "row" items = "${result.rows}">

                                <div class="col-md-5 d-flex align-items-stretch grid-margin">
                                    <div class="row flex-grow">
                                        <div class="col-12">
                                            <div class="card">
                                                <div class="card-body">
                                                    <a href="${pageContext.request.contextPath}/ad_view.jsp?id=${row.id}"><h4 class="card-title"><c:out value = "${row.id} - ${row.ad_subject}" /></h4></a>
                                                    <p class="card-description">
                                                        <img src="${pageContext.request.contextPath}${row.ad_image}" alt="picture of Massage - Full Body Massage" class="img-thumbnail" height="100" width="100"> 
                                                        <c:set var = "string1" value = "${row.ad_content}"/>

                                                        <c:set var = "string2" value = "${fn:substring(string1, 0, 250)}" />
                                                        ${string2}

                                                    </p>

                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </div>        

                            </c:forEach>




                        </div>
                    </div>
                    <!-- content-wrapper ends -->
                    <!-- partial:partials/_footer.html -->
                    <footer class="footer">
                        <div class="container-fluid clearfix">
                            <span class="text-muted d-block text-center text-sm-left d-sm-inline-block">Copyright © 2018
                                <a href="http://www.bootstrapdash.com/" target="_blank">arkenads</a>. All rights reserved.</span>
                            <span class="float-none float-sm-right d-block mt-1 mt-sm-0 text-center">
                                <!--ArkenAds Development-->

                            </span>
                        </div>
                    </footer>
                    <!-- partial -->
                </div>
                <!-- main-panel ends -->
            </div>
            <!-- page-body-wrapper ends -->
        </div>
        <!-- container-scroller -->

        <!-- plugins:js -->
        <script src="vendors/js/vendor.bundle.base.js"></script>
        <script src="vendors/js/vendor.bundle.addons.js"></script>
        <!-- endinject -->
        <!-- Plugin js for this page-->
        <!-- End plugin js for this page-->
        <!-- inject:js -->
        <script src="js/off-canvas.js"></script>
        <script src="js/misc.js"></script>
        <!-- endinject -->
        <!-- Custom js for this page-->
        <script src="js/dashboard.js"></script>
        <!-- End custom js for this page-->
    </body>

</html>
