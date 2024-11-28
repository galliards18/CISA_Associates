<aside id="layout-menu" class="layout-menu menu-vertical menu bg-menu-theme">
    <div class="app-brand demo" style="padding: 70px;">
        <div class="logo">
            <img style="border-radius: 500px; box-shadow: 2px 2px 20px #00008b; margin-top: 30px; margin-bottom: 5px;" src="../../assets/img/avatars/logo.png" width="100" height="100" alt="">
            <b>
                <p style="font-size: 20px; color: blue; text-shadow: 2px 2px 50px #00008b; padding-left: 10px;">Admin</p>
            </b>
        </div>
        <a href="javascript:void(0);" class="layout-menu-toggle menu-link text-large ms-auto d-block d-xl-none">
            <i class="bx bx-chevron-left bx-sm align-middle"></i>
        </a>
    </div>
    <ul class="menu-inner py-1">
        <!-- Dashboard -->
        <li class="menu-item">
            <a href="dashboard.php" class="menu-link">
                <i class="menu-icon tf-icons bx bx-chalkboard"></i>
                <div data-i18n="Analytics">Dashboard</div>
            </a>
        </li>
        <li class="menu-item">
            <a href="javascript:void(0);" class="menu-link menu-toggle">
                <i class="menu-icon tf-icons bx bx-user-circle"></i>
                <div data-i18n="Layouts">User</div>
            </a>
            <ul class="menu-sub">
                <li class="menu-item">
                    <a href="student.php" class="menu-link">
                        <div data-i18n="Analytics">Student</div>
                    </a>
                </li>
                <li class="menu-item">
                    <a href="employee.php" class="menu-link">
                        <div data-i18n="Analytics">Employee</div>
                    </a>
                </li>
            </ul>
        </li>
        <li class="menu-item">
            <a href="javascript:void(0);" class="menu-link menu-toggle">
                <i class="menu-icon tf-icons bx bx-calendar-check"></i>
                <div data-i18n="Analytics">Attendance</div>
            </a>
            <ul class="menu-sub">
                <li class="menu-item">
                    <a href="attendance_gate.php" class="menu-link">
                        <div data-i18n="Analytics">Gate Marking</div>
                    </a>
                </li>
                <li class="menu-item">
                    <a href="attendance_flag.php" class="menu-link">
                        <div data-i18n="Analytics">Flag Ceremony</div>
                    </a>
                </li>
            </ul>
        </li>
        <!-- <li class="menu-item">
            <a href="javascript:void(0);" class="menu-link menu-toggle">
                <i class="menu-icon tf-icons bx bx-calendar-event"></i>
                <div data-i18n="Layouts">Event</div>
            </a>
            <ul class="menu-sub">
                <li class="menu-item">
                    <a href="create_event.php" class="menu-link">
                        <div data-i18n="Analytics">Create Event</div>
                    </a>
                </li>
                <li class="menu-item">
                    <a href="archive_event.php" class="menu-link">
                        <div data-i18n="Analytics">Archive Event</div>
                    </a>
                </li>
            </ul>
        </li> -->
    </ul>
</aside>