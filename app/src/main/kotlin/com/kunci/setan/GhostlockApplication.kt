package com.kunci.setan

import android.app.Application
import com.kunci.setan.data.AndroidGhostlockRepository
import com.kunci.setan.domain.repository.GhostlockRepository

/** Application composition root. It is the only place that binds data implementations to domain ports. */
class GhostlockApplication : Application() {
    fun createRepository(): GhostlockRepository = AndroidGhostlockRepository(this)
}
