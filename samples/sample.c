/* C sample: struct, pointer, macro */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_NAME 32
#define SQUARE(x) ((x) * (x))

typedef struct {
    int id;
    char name[MAX_NAME];
    double score;
} Student;

static int counter = 0;

Student *create_student(int id, const char *name, double score) {
    Student *s = (Student *)malloc(sizeof(Student));
    if (s == NULL) {
        return NULL;
    }
    s->id = id;
    strncpy(s->name, name, MAX_NAME - 1);
    s->score = score;
    counter++;
    return s;
}

void print_student(const Student *s) {
    printf("ID: %d, Name: %s, Score: %.1f\n", s->id, s->name, s->score);
}

int main(int argc, char *argv[]) {
    // Create one student
    Student *alex = create_student(1, "Alex", 87.5);
    if (alex) {
        print_student(alex);
        free(alex);
    }
    for (int i = 0; i < 3; i++) {
        printf("%d squared = %d\n", i, SQUARE(i));
    }
    return 0;
}
