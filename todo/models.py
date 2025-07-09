from django.db import models
from django.utils import timezone


class Todo(models.Model):
    title: str = models.CharField(max_length=200)
    completed: bool = models.BooleanField(default=False)
    created_at = models.DateTimeField(default=timezone.now)

    def __str__(self) -> str:
        return self.title

    class Meta:
        ordering = ['-created_at']
