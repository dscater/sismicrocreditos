<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Salario extends Model
{
    use HasFactory;

    protected $fillable = [
        "user_id",
        "salario",
    ];

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }
}
