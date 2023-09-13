#!/bin/bash
#Here we go

#Variables de conexión a la base de datos
DB_HOST="localhost"
DB_NAME="students"
DB_USER="postgres"

#Funcion para consultas
consultTable() {
    echo "Consultemos una tabla"
    echo "Selecciona la tabla que quieres consultar: student, teacher, course, inscriptions"
    read tableName
    
    psql -h $DB_HOST -d $DB_NAME -U $DB_USER -W -c "SELECT * FROM $tableName;"
    
}

#Funcion para agregar registros en la tabla de estudiantes
addStudent() {
    echo "Agregemos un nuevo estudiante"
    echo "Cual es el nombre: "
    read name
    echo "Cual es su edad: "
    read age
    age=$(expr "$age" + 0)
    echo "Cual es su correo: "
    read mail
    echo "Cual es su telefono: "
    read cnumber
    cnumber=$(expr "$cnumber" + 0)
    
    psql -h $DB_HOST -d $DB_NAME -U $DB_USER -W -c "INSERT INTO student (name, age, mail, cellphone) VALUES ('"$name"', $age, '"$mail"', $cnumber);"
    
}

#Funcion para agregar registros en la tabla de profesores
addTeacher() {
    echo "Agregemos un nuevo profesor"
    echo "Cual es el nombre: "
    read name
    echo "Cual es su edad: "
    read age
    age=$(expr "$age" + 0)
    echo "Cual es su correo: "
    read mail
    echo "Cual es su telefono: "
    read cnumber
    cnumber=$(expr "$cnumber" + 0)
    
    psql -h $DB_HOST -d $DB_NAME -U $DB_USER -W -c "INSERT INTO teacher (name, age, mail, cellphone) VALUES ('"$name"', $age, '"$mail"', $cnumber);"
    
}

#Funcion para agregar registros en la tabla de clientes
addCourse() {
    echo "Agreguemos un curso"
    echo "Cual es el nombre: "
    read name
    echo "Describe el curso: "
    read description
    echo "Cual es el id del profesor: "
    read teacher
    teahcer=$(expr "$teahcer" + 0)
    
    psql -h $DB_HOST -d $DB_NAME -U $DB_USER -W -c "INSERT INTO course (name, description, teacher) VALUES ('"$name"', '"$description"', $teacher);"
    
}

#Funcion para agregar registros a la tabla de inscripcion 
addInscriptions() {
    echo "Inscribe en un curso"
    echo "Cual es el id del estudiante: "
    read student
    student=$(expr "$student" + 0)
    echo "Cual es el id del curso: "
    read course
    course=$(expr "$course" + 0)
    echo "Cual es la fecha de inicio: "
    read startdate
    echo "Cual es la fecha de finalizacion: "
    read enddate
    
    psql -h $DB_HOST -d $DB_NAME -U $DB_USER -W -c "INSERT INTO course (student, course, startdate, enddate) VALUES ($name, $course, "$startdate", "$enddate");"
}

#Funcion para agregar registros
addRegister() {
    echo "En que tabla quieres agregar un registro"
    opciones=("bike" "teacher" "course" "inscriptions" "exit")
    select opt in "${opciones[@]}"
    do
        case $opt in
            "student")
                addStudent; break
            ;;
            
            "teacher")
                addTeacher; break
            ;;
            
            "course")
                addCourse; break
            ;;

            "inscriptions")
                addInscriptions; break
            ;;

            "exit") break 2
            ;;
            *) echo "Opcion no válida."
        esac
    done
}

#Funcion para alterar registros
alterRegister() {
    echo "Editemos los registros"
    echo "Selecciona una tabla: student, teacher, course, inscriptions"
    read tableName
    echo "Ingresa el ID del registro que deseas editar: "
    read recordId

    if [[ "$tableName" == "student" ]]; then
        echo "Elige el campo que deseas editar: name, age, mail, cellphone"
        read field

        echo "Ingresa el nuevo valor: "
        read newValue
    elif [[ "$tableName" == "teacher" ]]; then  
        echo "Elige el campo que deseas editar: name, age, mail, cellphone"
        read field

        echo "Ingresa el nuevo valor: "
        read newValue
    elif [[ "$tableName" == "course" ]]; then  
        echo "Elige el campo que deseas editar: name, description, teacher"
        read field

        echo "Ingresa el nuevo valor: "
        read newValue
    elif [[ "$tableName" == "inscriptions" ]]; then 
        echo "Elige el campo que deseas editar: student, course, startdate, enddate"
        read field

        echo "Ingresa el nuevo valor: "
        read newValue
    fi

    psql -h $DB_HOST -d $DB_NAME -U $DB_USER -W -c "UPDATE $tableName SET $field = '$newValue' WHERE id = $recordId;"
}

#Funcion para la eliminacion de registros
deleteRegister() {
    echo "Elimimenos registros"
    echo "Selecciona una tabla: student, teacher, course, inscriptions"
    read tableName
    echo "Ingresa el ID del registro que deseas eliminar: "
    read recordId
    
    psql -h $DB_HOST -d $DB_NAME -U $DB_USER -W -c "DELETE FROM $tableName WHERE id = $recordId;"
}

#Menu
echo "╲╲╭┻┻┻┻┻┻┻┻┻┻╮╱╱
╲╲┃╱▔▔╲┊┊╱▔▔╲┃╱╱
╭━┫▏╭╮▕┊┊▏╭╮▕┣━╮
┃╭┫╲┻┻╱┊┊╲┻┻╱┣╮┃
┃╰╮╱▔▔╱◼◼╲▔▔╲╭╯┃
╰━┓▏┏┳┳┳┳┳┳┓▕┏━╯
╱╱┃▏╰┻┻┻┻┻┻╯▕┃╲╲"

echo "Hola, mi nombre es Baymax, tu asisente de terminal personal, en que te puedo ayudar: "

opciones=("consultar una tabla" "agregar registros" "alterar registros" "eliminar registros" "salir")
select opt in "${opciones[@]}"
do
    case $opt in
        "consultar una tabla")
            consultTable; break
        ;;
        
        "agregar registros")
            addRegister; break
        ;;
        
        "alterar registros")
            alterRegister; break
        ;;
        
        "eliminar registros")
            deleteRegister; break
        ;;
        
        "salir") break 2
        ;;
        *) echo "Opcion no válida."
    esac
done