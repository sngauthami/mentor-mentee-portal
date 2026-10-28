# Mentor-Mentee Portal

A simple website where mentees enter their details and marks, mentors view them and leave notes or recommendations, and the HOD/admin can view everything.

## Tech used
- Frontend: HTML, CSS, JavaScript (no framework)
- Backend / Database: Supabase (PostgreSQL + Auth + Row Level Security)

## Roles
| Role | Can do |
|------|--------|
| Mentee | Add own marks, pick a mentor, read mentor notes |
| Mentor | See marks of own mentees, add notes/recommendations |
| HOD | View all mentees, marks, mentors and note counts |

## Database tables
`profiles` (id, name, role, mentor_id), `marks` (mentee_id, subject, marks), `notes` (mentee_id, mentor_id, note, seen). Full SQL in `schema.sql`.

## How to run
1. Create a Supabase project and run `schema.sql` in the SQL Editor.
2. Put your Project URL and anon key in `supabase.js`.
3. Run `python -m http.server 5500` in this folder and open http://localhost:5500

## AI assistance
Prompts used are logged in `prompts.md`.
