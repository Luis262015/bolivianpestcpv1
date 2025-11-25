<?php

use Illuminate\Support\Facades\Route;
use Inertia\Inertia;
use Laravel\Fortify\Features;

Route::get('/', function () {
    return Inertia::render('welcome', [
        'canRegister' => Features::enabled(Features::registration()),
    ]);
})->name('home');

// ------ PRUEBAS DE LANDING --------------------
Route::get('/landing', function () {
    return Inertia::render('landing');
})->name('landing');

// ------ PRUEBAS DE MAPA --------------------
Route::get('/drawing', function () {
    return Inertia::render('drawing');
})->name('drawing');

// ------ PRUEBAS DE CALENDARIO --------------------
Route::get('/calendar', function () {
    return Inertia::render('calendar');
})->name('calendar');


Route::middleware(['auth', 'verified'])->group(function () {
    Route::get('dashboard', function () {
        return Inertia::render('dashboard');
    })->name('dashboard');
});

require __DIR__ . '/settings.php';