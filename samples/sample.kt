package com.example.app

import androidx.compose.foundation.layout.Column
import androidx.compose.material3.Button
import androidx.compose.material3.Text
import androidx.compose.runtime.*

// Kotlin + Jetpack Compose sample
const val MAX_COUNT = 10

data class User(val name: String, val age: Int = 0)

sealed class UiState {
    object Loading : UiState()
    data class Success(val users: List<User>) : UiState()
    data class Error(val message: String) : UiState()
}

class UserViewModel {
    private val _state = mutableStateOf<UiState>(UiState.Loading)
    val state: State<UiState> get() = _state

    fun load() {
        _state.value = UiState.Success(listOf(User("Alex", 21), User("Sara")))
    }
}

@Composable
fun Counter(modifier: Modifier = Modifier, onDone: () -> Unit) {
    var count by remember { mutableStateOf(0) }

    Column(modifier = modifier) {
        Text(text = "Count: $count of ${MAX_COUNT}")
        Button(onClick = {
            if (count < MAX_COUNT) count++ else onDone()
        }) {
            Text("Add")
        }
    }
}

fun describe(state: UiState): String = when (state) {
    is UiState.Loading -> "Loading..."
    is UiState.Success -> "${state.users.size} users found"
    is UiState.Error -> state.message
}
