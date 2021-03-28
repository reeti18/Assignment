package main

import (
	"bufio"
	"database/sql"
	"io"
	"log"
	"os"
	"strings"

	_ "github.com/denisenkom/go-mssqldb"
)

func main() {
	rows := readFromFile("PatientInfo.txt")
	insertRowsToDatabase(rows)
}

func readFromFile(fileName string) []string {

	f, err := os.Open(fileName)
	if err != nil {
		log.Fatalf("Cannot open '%s': %s\n", fileName, err.Error())
	}

	rows := make([]string, 0)

	reader := bufio.NewReader(f)

	for {
		str, err := reader.ReadString('\n')
		if err == io.EOF {
			break
		}
		rows = append(rows, str)
	}

	defer f.Close()

	return rows
}

func insertRowsToDatabase(rows []string) {

	// Connecting to the database.
	db, err := sql.Open("mssql", "server=localhost;Initial Catalog=dbo;user id=sa; password=sa@123; database=master; port=1433")
	if err != nil {
		log.Print("Unable to connect DB, Getting the error: ")
		log.Fatal(err)
	}
	stmt, err := db.Prepare("INSERT INTO dbo.Customer VALUES(?,?,?,?,?,?,?,?,?,?)")
	if err != nil {
		log.Fatal(err)
	}
	// Insert the rows, omitting the first header row from the txt file.
	for _, row := range rows[1:] {

		str := strings.Split(row, "|")

		if str[1] == "D" {
			_, err := stmt.Exec(str[2], str[3], str[4], str[5], str[6], str[7], str[8], str[9], str[10], str[11])
			if err != nil {
				println("Please read the below error")
				log.Fatal(err)
			}
		}
	}
	defer db.Close()
}
