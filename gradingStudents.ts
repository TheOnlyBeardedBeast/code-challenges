function gradingStudents(grades: number[]): number[] {
    return grades.map(grade => {
        if(grade < 38){
            return grade;
        }
        
        const modulo = grade % 5;
        
        if(modulo >= 3){
            return grade + 5 - modulo;
        }
        
        return grade;
    });
}