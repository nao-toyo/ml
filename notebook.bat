@if "%1"=="" (

 pipenv run jupyter notebook ./notebook

) else (

pipenv run jupyter notebook %1)
