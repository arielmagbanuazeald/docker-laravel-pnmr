<?php

use App\User;
use Illuminate\Support\Facades\Cache;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});

Route::get('/home', function () {
    return ['awts' => 'ggness'];
});

Route::get('/users', function () {
    return User::all();
});

Route::get('/store_cache', function () {
    $expiresAt = now()->addMinutes(30);
    Cache::put('test', 'amazing value!!!', $expiresAt);

    return [
        'cache' => 'Cached stored!'
    ];
});

Route::get('/read_cache', function () {
    $cacheDriverDefault = config('cache.default');
    $cacheDriverENV = env('CACHE_DRIVER');
    $hasKey = Cache::has('key');
    $cacheValue = Cache::get('key');

    return [
        'cache_driver_default' => $cacheDriverDefault,
        'cache_driver_env' => $cacheDriverENV,
        'hasKey' => $hasKey,
        'cache' => $cacheValue
    ];
});

