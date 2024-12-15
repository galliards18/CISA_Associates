<script
    src="https://code.jquery.com/jquery-3.7.1.min.js"
    integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
    crossorigin="anonymous"></script>
<script>
    $(document).ready(function() {
        // Set interval to auto-update content
        setInterval(function() {
            $("#test").load("data.txt", {
                //
            }, function() {
                console.log("Comment updated automatically.");
            });
        }, 1000); // Update every 1 second
    });
</script>

<aside id="layout-menu" class="layout-menu menu-vertical menu bg-menu-theme">
    <div class="app-brand demo" style="padding: 70px;">
        <div class="logo">
            <img style="border-radius: 500px; box-shadow: 2px 2px 20px #00008b; margin-top: 30px; margin-bottom: 5px;" src="../../assets/img/avatars/logo.png" width="100" height="100" alt="">
            <b>
                <p style="font-size: 20px; color: blue; text-shadow: 2px 2px 50px #00008b; padding-left: 10px;">Student</p>
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
                <div data-i18n="Layouts">Attendance</div>
            </a>
            <ul class="menu-sub">
                <li class="menu-item">
                    <a href="student_attendance_information_flag.php" class="menu-link">
                        <div data-i18n="Analytics">Flag</div>
                    </a>
                </li>
            </ul>
        </li>
    </ul>
</aside>