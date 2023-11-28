<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Pago extends Model
{
    use HasFactory;

    protected $fillable  = [
        "user_id",
        "tipo_prestamo",
        "prestamo_id",
        "plan_pago_id",
        "cliente_id",
        "grupo_id",
        "grupo_plan_pago_id",
        "nro_cuota",
        "monto",
        "interes",
        "dias_mora",
        "monto_mora",
        "monto_total",
        "fecha_pago",
    ];

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    public function prestamo()
    {
        return $this->belongsTo(Prestamo::class, 'prestamo_id');
    }

    public function plan_pago_id()
    {
        return $this->belongsTo(PlanPago::class, 'plan_pago_id_id');
    }

    public function cliente()
    {
        return $this->belongsTo(Cliente::class, 'cliente_id');
    }
}
