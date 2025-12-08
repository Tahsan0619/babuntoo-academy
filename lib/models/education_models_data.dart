import 'education_model.dart';

final List<EducationModel> educationModels = [
  EducationModel(
    inventorName: "Maria Montessori",
    yearPublished: "1907",
    sections: [
      EducationModelSection(
        title: "Curriculum Structure",
        points: [
          "The organization and subjects taught at different education levels.",
          "Emphasis on specific disciplines.",
        ],
      ),
      EducationModelSection(
        title: "Teaching Methods",
        points: [
          "Instructional approaches used.",
          "Use of technology and interactive tools in classrooms.",
        ],
      ),
      EducationModelSection(
        title: "Teacher Training and Qualifications",
        points: [
          "Requirements for becoming a teacher.",
          "Ongoing professional development and support systems.",
        ],
      ),
      EducationModelSection(
        title: "Assessment and Evaluation",
        points: [
          "How student learning is measured (standardized tests, continuous assessment, performance tasks).",
          "Grading systems and feedback mechanisms.",
        ],
      ),
      EducationModelSection(
        title: "Access and Equity",
        points: [
          "Availability of education for all demographics.",
          "Policies addressing gender, socio-economic status, disabilities.",
          "Support systems for disadvantaged or special-needs students.",
        ],
      ),
      EducationModelSection(
        title: "School Environment and Culture",
        points: [
          "Classroom size and student-teacher ratio.",
          "Discipline approaches, inclusivity, and student participation.",
          "Integration of cultural or moral education.",
        ],
      ),
    ],
  ),
  EducationModel(
    inventorName: "John Dewey",
    yearPublished: "1896",
    sections: [
      EducationModelSection(
        title: "Curriculum Structure",
        points: [
          "Project-based curriculum.",
          "Flexible grade levels.",
        ],
      ),
      EducationModelSection(
        title: "Teaching Methods",
        points: [
          "Experiential learning techniques.",
          "Group discussions, real-life problem solving.",
        ],
      ),
      EducationModelSection(
        title: "Teacher Training and Qualifications",
        points: [
          "Bachelor’s degree in Education.",
          "Continuous in-service professional development.",
        ],
      ),
      EducationModelSection(
        title: "Assessment and Evaluation",
        points: [
          "Emphasis on formative assessment.",
          "Portfolio-based evaluation.",
        ],
      ),
      EducationModelSection(
        title: "Access and Equity",
        points: [
          "Open access to all students.",
          "Support for disadvantaged learners.",
        ],
      ),
      EducationModelSection(
        title: "School Environment and Culture",
        points: [
          "Student-centered classroom communities.",
          "Collaborative and respectful environment.",
        ],
      ),
    ],
  ),
];
