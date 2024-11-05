:- dynamic task/4.

create_task(TaskID, Description, Assignee) :-
    \+ task(TaskID, _, _, _),
    assertz(task(TaskID, Description, Assignee, false)),
    format('Task created: ~w.~n', [TaskID]).

assign_task(TaskID, NewAssignee) :-
    retract(task(TaskID, Description, _, Status)),
    assertz(task(TaskID, Description, NewAssignee, Status)),
    format('Task ~w assigned to user: ~w.~n', [TaskID, NewAssignee]).

mark_completed(TaskID) :-
    retract(task(TaskID, Description, Assignee, false)),
    assertz(task(TaskID, Description, Assignee, true)),
    format('Task ~w marked as completed.~n', [TaskID]).

display_tasks :-
    forall(task(TaskID, Description, Assignee, Status),
        (format('Task ~w:~n', [TaskID]),
         format('- Description: ~w~n', [Description]),
         format('- Assignee: ~w~n', [Assignee]),
         format('- Completion status: ~w~n', [Status]))).

display_tasks_assigned_to(User) :-
    format('Tasks assigned to ~w:~n', [User]),
    forall(task(TaskID, Description, User, Status),
        (format('Task ~w:~n', [TaskID]),
         format('- Description: ~w~n', [Description]),
         format('- Completion status: ~w~n', [Status]))).

display_completed_tasks :-
    format('Completed tasks:~n', []),
    forall(task(TaskID, Description, Assignee, true),
        (format('Task ~w:~n', [TaskID]),
         format('- Description: ~w~n', [Description]),
         format('- Assignee: ~w~n', [Assignee]))).
