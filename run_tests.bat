@echo off
echo Running Sage login test...
robot --outputdir results --log logs/log.html --report reports/report.html --output logs/output.xml tests/login/login.robot
echo.
echo Done. Check results\logs\log.html for details.
pause