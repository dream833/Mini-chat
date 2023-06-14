cls
set update=%1
git add .
git commit . -m "%update% | @UMA12345-cmdes"
git push -f origin UMA12345-cmdes
echo "Deploy Done"
