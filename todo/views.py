from django.http import HttpRequest, HttpResponse
from django.shortcuts import get_object_or_404, redirect, render

from .models import Todo


def todo_list(request: HttpRequest) -> HttpResponse:
    """Display all todos and handle new todo creation."""
    if request.method == 'POST':
        title = request.POST.get('title', '').strip()
        if title:
            Todo.objects.create(title=title)
        return redirect('todo_list')

    todos = Todo.objects.all()
    return render(request, 'todo/todo_list.html', {'todos': todos})


def toggle_todo(request: HttpRequest, todo_id: int) -> HttpResponse:
    """Toggle the completed status of a todo."""
    todo = get_object_or_404(Todo, id=todo_id)
    todo.completed = not todo.completed
    todo.save()
    return redirect('todo_list')


def delete_todo(request: HttpRequest, todo_id: int) -> HttpResponse:
    """Delete a todo."""
    todo = get_object_or_404(Todo, id=todo_id)
    todo.delete()
    return redirect('todo_list')
