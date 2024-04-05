<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

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
        "tipo_pago",
        "fecha_pago",
    ];

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    public function grupo()
    {
        return $this->belongsTo(Grupo::class, 'grupo_id');
    }

    public function prestamo()
    {
        return $this->belongsTo(Prestamo::class, 'prestamo_id');
    }

    public function plan_pago()
    {
        return $this->belongsTo(PlanPago::class, 'plan_pago_id');
    }

    public function grupo_plan_pago()
    {
        return $this->belongsTo(PlanPago::class, 'grupo_plan_pago_id');
    }

    public function cliente()
    {
        return $this->belongsTo(Cliente::class, 'cliente_id');
    }

    // verifica finalizados
    public static function verifica_individual(Prestamo $prestamo)
    {
        $nro_pagos_realizados = $prestamo->nro_pagos_realizados;

        if ($nro_pagos_realizados == $prestamo->plazo) {
            $prestamo->finalizado = 1;
            $prestamo->save();
        }
        return $prestamo;
    }
    public static function verifica_grupal(Grupo $grupo)
    {
        $nro_pagos_realizados = $grupo->nro_pagos_realizados;

        if ($nro_pagos_realizados == $grupo->plazo) {
            $grupo->finalizado = 1;
            $grupo->save();

            DB::update("UPDATE prestamos SET finalizado = 1 WHERE grupo_id = $grupo->id");
        }
        return $grupo;
    }
}
