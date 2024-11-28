<nav class="layout-navbar container-xxl navbar navbar-expand-xl navbar-detached align-items-center bg-navbar-theme" id="layout-navbar">
    <div class="layout-menu-toggle navbar-nav align-items-xl-center me-3 me-xl-0 d-xl-none">
        <a class="nav-item nav-link px-0 me-xl-4" href="javascript:void(0)">
            <i class="bx bx-menu bx-sm"></i>
        </a>
    </div>
    <div class="navbar-nav-right d-flex align-items-center" id="navbar-collapse">
        <center>
            <p style="font-size: 18px; padding-top: 15px;"><b>Southern Leyte State University</b></p>
        </center>
        <ul class="navbar-nav flex-row align-items-center ms-auto">
            <!-- Place this tag where you want the button to render. -->
            <!-- User -->
            <li class="nav-item navbar-dropdown dropdown-user dropdown">
                <a class="nav-link dropdown-toggle hide-arrow" href="javascript:void(0);" data-bs-toggle="dropdown">
                    <div class="avatar avatar-online">
                    <img src="../../assets/img/avatars/profile.png" alts class="w-px-40 h-auto rounded-circle" />
                    </div>
                </a>
                <ul class="dropdown-menu dropdown-menu-end">
                    <li>
                        <a class="dropdown-item" href="#">
                            <div class="d-flex">
                                <div class="flex-shrink-0 me-3">
                                    <div class="avatar avatar-online">
                                        <img src="../../assets/img/avatars/profile.png" alt class="w-px-40 h-auto rounded-circle" />
                                    </div>
                                </div>
                                <div class="flex-grow-1">
                                    <span class="fw-semibold d-block"></span>
                                    <small class="text-muted">Employee</small>
                                </div>
                            </div>
                        </a>
                    </li>
                    <li>
                        <a class="dropdown-item" href="employee.php">
                            <i class="bx bx-user me-2"></i><span>My Profile</span>
                        </a>
                    </li>
                    <li>
                        <a class="dropdown-item" href="#">
                            <i class="bx bx-cog me-2"></i><span>Settings</span>
                        </a>
                    </li>
                    <li class="dropdown">
                        <div class="dropdown-item d-flex align-items-center">
                            <i class="bx bx-printer me-2"></i>
                            <select id="print-options" class="form-select" onchange="handlePrintRedirect(this)">
                                <option value="" disabled selected>Select an option</option>
                                <option value="print/print_flag.php">Flag Ceremony Campus</option>
                                <option value="print/print_flag_department.php">Flag Ceremony Department</option>
                                <option value="print/print_gate.php">Gate Marking</option>
                            </select>
                        </div>
                    </li>
                    <script>
                        function handlePrintRedirect(select) {
                            const selectedValue = select.value;
                            if (selectedValue) {
                                window.location.href = selectedValue;
                            }
                        }
                    </script>
                    <li>
                        <a class="dropdown-item" href="qr/generate_qr.php">
                            <i class="bx bx-qr me-2"></i><span>OTQRC</span>
                        </a>
                    </li>
                    <li>
                        <a class="dropdown-item" href="../logout.php">
                            <i class="bx bx-power-off me-2"></i>
                            <span class="align-middle">Log Out</span>
                        </a>
                    </li>
                </ul>
            </li>
            <!--/ User -->
        </ul>
    </div>
</nav>